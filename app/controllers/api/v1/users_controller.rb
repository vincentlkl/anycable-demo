class Api::V1::UsersController < ActionController::API
  def create
    ActionCable.server.broadcast('message_channel', SecureRandom.urlsafe_base64(5))
    render json: { }, head: :ok
  end
end