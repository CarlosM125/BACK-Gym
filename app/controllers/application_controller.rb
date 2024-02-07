class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token) if token
    @current_user = User.find(decoded_token['user_id']) if decoded_token
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end
