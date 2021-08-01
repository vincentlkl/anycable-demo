class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
   
  def perform_action(data)
    if data['action'] == 'token'
      ActionCable.server.broadcast('message_channel', "Bearbear #{data['message']}")    
    end
  end
end
