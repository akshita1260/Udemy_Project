class ApiController < ActionController::API
	include JsonWebToken
  before_action :authenticate_user
  before_action :check_instructor
  before_action :check_student
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
      render json: {message: "Please login yourself!!"}
  end

  def check_instructor
    return render json: {message: "No user found"} unless @current_user.type == "Instructor"
  end

  def check_student
    return render json: {message: "No user found"} unless @current_user.type == "Student"
  end
end