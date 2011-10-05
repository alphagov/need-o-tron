class SatisfiedNeedListener
  class_attribute :client

  def listen
    Signal.trap('TERM') do
      client.close
      exit
    end
    client.subscribe('/queue/need_satisfied') do |message|
      begin
        message_body = message && message.body
        message = JSON.parse(message_body)
        panopticon = Panopticon.find(message['panopticon_id'])
        need = Need.find(panopticon.need_id)
        need.update_attributes!(status: Need::DONE, url: panopticon.public_url)
      rescue JSON::ParserError => e
        Rails.logger.error("Unable to parse message #{message_body} because of #{e}")
      rescue e
        Rails.logger.error("Unable to process message #{message_body} because of #{e}")
      end
    end
    client.join
    client.close
  end
  
  def client
    self.class.client ||= Stomp::Client.new(STOMP_CONFIGURATION)
  end
end
