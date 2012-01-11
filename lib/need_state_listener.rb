require 'gds_api/helpers'

class NeedStateListener
  include GdsApi::Helpers
  cattr_accessor :client, :logger

  def initialize
    @marples = Marples::Client.new self.class.client, "need-state-listener-#{Process.pid}", logger
  end

  def listen
    Signal.trap('TERM') do
      client.close
      exit
    end

    listen_on_published
    listen_on_created
    listen_on_deleted

    @marples.join
  end

  def public_url(artefact)
    Plek.current.find('frontend') + '/' + artefact.slug
  end

  def load_artefact(id_or_slug)
    panopticon_api.artefact_for_slug(id_or_slug)
  end
  
  def act_on_changed_publication(publication, new_status)
    artefact = load_artefact(publication['panopticon_id'])
    need = Need.find(artefact.need_id)
    need.update_attributes!(status: new_status, url: public_url(artefact))
  rescue => e
    logger.error("Unable to process message #{publication}")
    logger.error [ e.message, e.backtrace ].flatten.join("\n")
  end

  def act_on_published(publication)
    act_on_changed_publication(publication, Need::DONE)
  end
  
  def act_on_created(publication)
    act_on_changed_publication(publication, Need::IN_PROGRESS)
  end

  def act_on_deleted(artefact)
    need = Need.find artefact['need_id']
    need.update_attributes!(status: Need::FORMAT_ASSIGNED)
  rescue => e
    logger.error("Unable to process message #{artefact}")
    logger.error [ e.message, e.backtrace ].flatten.join("\n")
  end

  def listen_on_published
    @marples.when 'publisher', '*', 'published' do |publication|
      logger.info "Found publication #{publication}"
      act_on_published(publication)
      logger.info "Finished processing message #{publication}"
    end
    logger.info "Listening for published objects in Publisher"
  end

  def listen_on_created
    @marples.when 'publisher', '*', 'created' do |publication|
      logger.info "Found publication #{publication}"
      act_on_created(publication)
      logger.info "Finished processing message #{publication}"
    end
    logger.info "Listening for created objects in Publisher"
  end

  def listen_on_deleted
    @marples.when 'panopticon', 'artefacts', 'destroyed' do |artefact|
      logger.info "Artefact #{artefact} was deleted in Panopticon"
      act_on_deleted(publication)
      logger.info "Finished processing message #{artefact}"
    end
    logger.info "Listening for destroyed objects in Publisher"
  end

  def logger
    @logger ||= begin
      logger = Logger.new STDOUT
      logger.level = Logger::DEBUG
      logger
    end
  end
end
