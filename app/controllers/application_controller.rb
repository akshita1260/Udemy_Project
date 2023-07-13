class ApplicationController < ActionController::API
  
    include JsonWebToken
    private
    def authenticate_instructor
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_instructor = User.find(decoded[:instructor_id])
      rescue JWT::DecodeError
      render json: {message: "Please login yourself!!"}
      rescue ActiveRecord::RecordNotFound
      render json: { message: "No record found with this id"}
    end
  
    def authenticate_student
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_student = User.find(decoded[:student_id])
      rescue JWT::DecodeError
      render json: {message: "Please login yourself!!"}
      rescue ActiveRecord::RecordNotFound
      render json: { message: "No record found with this id"}
    end
  end
  