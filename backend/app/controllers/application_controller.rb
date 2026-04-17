class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  before_action :authenticate_user
  
  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        @current_user = User.find(decoded[0]['user_id'])
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Authentication required' }, status: :unauthorized unless skip_auth?
    end
  end
  
  def current_user
    @current_user
  end
  
  private
  
  def skip_auth?
    controller_name == 'auth' && action_name.in?(%w[register login])
  end
end