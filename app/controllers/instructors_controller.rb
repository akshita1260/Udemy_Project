class InstructorsController < ApplicationController
  before_action :authenticate_instructor, except: [:login, :create]

  def create
    instruct = Instructor.new(instructor_params)
    return render json: {message: "Hey #{instruct.name}, your account created successfully!!"} if instruct.save   
    render json: {errors: instruct.errors.full_messages}
  end

  def login
    instruct =Instructor.find_by(email: params[:email],password: params[:password])
    if instruct
      token = jwt_encode(instructor_id:  instruct.id)
      render json: {message: "#{instruct.name} you logged in successfully...",token: token}, status: :ok
    else
      render json: {message: "Invalid email and password"}
    end
  end

  def show
    instruct = Instructor.find(@current_instructor.id)
    render json: instruct
  end

  def update
    instruct = Instructor.find(@current_instructor.id)
    return render json: {message: " Updated successfully!!", data:instruct} if instruct.update(instructor_params)  
    render json: {errors: instruct.errors.full_messages}
  end

  def destroy
    instruct = Instructor.find(@current_instructor.id)    
    return render json: { message: "Data of #{instruct.name} deleted successfully!" } if instruct.destroy
    render json: { errors: instruct.errors.full_messages }
  end

  private
  def instructor_params
    params.permit(:name, :email, :password)
  end
end
