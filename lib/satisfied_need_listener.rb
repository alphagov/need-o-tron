class SatisfiedNeedListener
  class_attribute :client

  def listen
    Signal.trap('TERM') do
      client.close
      exit
    end
    client.subscribe('/queue/need_satisfied', :ack => 'client') do |message|
      Rails.logger.info("Message #{message.headers['message-id']} received")
      begin
        payload = JSON.parse(message.body)
        Rails.logger.info("Processing artefact #{payload['panopticon_id']}")
        panopticon = Panopticon.find(payload['panopticon_id'])
        Rails.logger.info("Getting need ID from Panopticon")
        need = Need.find(panopticon.need_id)
        Rails.logger.info("Marking need #{need.id} as done")
        need.update_attributes!(status: Need::DONE, url: panopticon.public_url)
        Rails.logger.info("Marked as done; acking message")
        client.acknowledge message
      rescue JSON::ParserError => e
        Rails.logger.error("Unable to parse message #{message.body} because of #{e}")
      rescue => e
        Rails.logger.error("Unable to process message #{message.body} because of #{e}")
      end
      Rails.logger.info "Finished processing message #{message.headers['message-id']}"
    end
    Rails.logger.info "Listening for messages on /queue/need_satisfied"
    client.join
    client.close
  end
  
  def client
    self.class.client ||= Stomp::Client.new(STOMP_CONFIGURATION)
  end
end
