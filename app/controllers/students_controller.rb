class StudentsController < ApplicationController
  before_action :authenticate_student, except: [:login, :create]
   
  def create
    student = Student.new(student_params)
    return render json: {message: "Hey #{student.name}, your account created successfully!!"} if student.save
    render json: {errors: student.errors.full_messages} 
  end

  def login
    student =Student.find_by(email: params[:email],password: params[:password])
    if  student
      token = jwt_encode(student_id:  student.id)
      render json: {message: "#{student.name} you loggged in successfully",token: token}, status: :ok
    else
      render json: {message: "invalid login"} 
    end
  end

  def show
    student = Student.find(@current_student.id)
    render json: student
   end
 
  def update
    student = Student.find(@current_student.id)
    return render json: {message: " Updated successfully!!", data:student} if student.update(student_params) 
    render json: {errors: instruct.errors.full_messages}
  end
 
  def destroy
    student = Student.find(@current_student.id)    
    return render json: { message: "Data of #{student.name} deleted successfully!" } if student.destroy
      render json: { errors: instruct.errors.full_messages }
  end
 
  private
  def student_params
    params.permit(:name, :email, :password)
  end
end
