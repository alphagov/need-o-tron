class SatisfiedNeedListener
  class_attribute :client

  def listen
    Signal.trap('TERM') do
      client.close
      exit
    end
    
    marples = Marples::Client.new client, "statisfied-need-listener-#{Process.pid}", logger
    marples.when 'publisher', '*', 'published' do |publication|
      logger.info "Found publication #{publication}"
      begin
        logger.info("Processing artefact #{publication['panopticon_id']}")
        panopticon = Panopticon.find(publication['panopticon_id'])
        logger.info("Getting need ID from Panopticon")
        need = Need.find(panopticon.need_id)
        logger.info("Marking need #{need.id} as done")
        need.update_attributes!(status: Need::DONE, url: panopticon.public_url)
        logger.info("Marked as done")
      rescue => e
        logger.error("Unable to process message #{publication}")
        logger.error [ e.message, e.backtrace ].flatten.join("\n")
      end
      logger.info "Finished processing message #{publication}"
    end
    logger.info "Listening for published objects in Publisher"
    marples.join
  end
  
  def logger
      @logger ||= begin
        logger = Logger.new STDOUT
        logger.level = Logger::DEBUG
        logger
      end
  end
  
  def client
    self.class.client ||= Stomp::Client.new(STOMP_CONFIGURATION)
  end
end
