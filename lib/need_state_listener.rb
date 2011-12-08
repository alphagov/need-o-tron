require 'gds_api/panopticon'

class NeedStateListener

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
    api = GdsApi::Panopticon.new(Plek.current.environment)
    api.artefact_for_slug(id_or_slug)
  end

  def listen_on_published
    @marples.when 'publisher', '*', 'published' do |publication|
      logger.info "Found publication #{publication}"
      begin
        logger.info("Processing artefact #{publication['panopticon_id']}")
        artefact = load_artefact(publication['panopticon_id'])

        logger.info("Getting need ID from Panopticon")
        need = Need.find(artefact.need_id)
        logger.info("Marking need #{need.id} as done")
        need.update_attributes!(status: Need::DONE, url: public_url(artefact))
        logger.info("Marked as done")
      rescue => e
        logger.error("Unable to process message #{publication}")
        logger.error [ e.message, e.backtrace ].flatten.join("\n")
      end
      logger.info "Finished processing message #{publication}"
    end
    logger.info "Listening for published objects in Publisher"
  end

  def listen_on_created
    @marples.when 'publisher', '*', 'created' do |publication|
      logger.info "Found publication #{publication}"
      begin
        logger.info("Processing artefact #{publication['panopticon_id']}")
        artefact = load_artefact(publication['panopticon_id'])

        logger.info("Getting need ID from Panopticon")
        need = Need.find(artefact.need_id)
        logger.info("Marking need #{need.id} as in progress")
        need.update_attributes!(status: Need::IN_PROGRESS, url: public_url(artefact))
        logger.info("Marked as in progress")
      rescue => e
        logger.error("Unable to process message #{publication}")
        logger.error [ e.message, e.backtrace ].flatten.join("\n")
      end
      logger.info "Finished processing message #{publication}"
    end
    logger.info "Listening for created objects in Publisher"
  end

  def listen_on_deleted
    @marples.when 'panopticon', 'artefacts', 'destroyed' do |artefact|
      logger.info "Artefact #{artefact} was deleted in Panopticon"
      begin
        need = Need.find artefact['need_id']
        logger.info("Marking need #{need.id} as format assigned")
        need.update_attributes!(status: Need::FORMAT_ASSIGNED)
        logger.info("Marked as format assigned")
      rescue => e
        logger.error("Unable to process message #{artefact}")
        logger.error [ e.message, e.backtrace ].flatten.join("\n")
      end
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
