class Api::V1::RegistrationsController < ApplicationController
  def create
    gimnasio = Gimnasio.find_by(id: params[:user][:gimnasio_id])
    user = User.new(user_params)

    if user.save
      render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :gimnasio_id)
  end
end
