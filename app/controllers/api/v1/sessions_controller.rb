class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token , expiracion = generate_token(user.id)
      render json: { token: token, expiracion: expiracion , user: user.gimnasio_id}
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
  private

  def generate_token(user_id)
    expiracion = 1.hour.from_now.to_i
    payload = { user_id: user_id, exp: expiracion}
    secret_key = 'secret' 
    token = JWT.encode(payload, secret_key, 'HS256')
    return token, expiracion
  end
end
