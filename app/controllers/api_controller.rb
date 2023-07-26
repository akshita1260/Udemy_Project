class ApiController < ActionController::API
	include JsonWebToken
  include Pundit::Authorization

  before_action :authenticate_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
  
  private
  
  def authenticate_user
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user= User.find(decoded[:user_id])
  rescue JWT::DecodeError
    render json: {message: "First login yourself!!"}
  end

  def current_user
    @current_user
  end

  def user_not_authorized
    render json: {message: "You are not authorized to perform this action."}
  end
end