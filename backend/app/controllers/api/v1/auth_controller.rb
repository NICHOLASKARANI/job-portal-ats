class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user, only: [:register, :login]
  
  def register
    user = User.new(user_params)
    if user.save
      token = generate_token(user)
      render json: { user: user.as_json(only: [:id, :email, :role]), token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { user: user.as_json(only: [:id, :email, :role]), token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def me
    render json: current_user.as_json(only: [:id, :email, :role])
  end
  
  private
  
  def user_params
    params.permit(:email, :password, :password_confirmation, :role)
  end
  
  def generate_token(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)
  end
end