class StudentsController < ApiController
  # skip_before_action :authenticate_user,only: [:login, :create]
  # skip_before_action :check_instructor
  # skip_before_action :check_student,only: [:login, :create]
   
  # def create
  #   student = User.new(student_params)
  #   return render json: {message: "Hey #{student.name}, your account created successfully!!"} if student.save
  #   render json: {errors: student.errors.full_messages} 
  # end

  # def login
  #   student =User.find_by(email: params[:email],password: params[:password])
  #   if  student
  #     token = jwt_encode(user_id:  student.id)
  #     render json: {message: "#{student.name} you loggged in successfully",token: token}, status: :ok
  #   else
  #     render json: {message: "invalid login"} 
  #   end
  # end

  # def show
  #    student = @current_user
  #   render json: student
  #  end
 
  # def update
  #   student = @current_user
  #   return render json: {message: " Updated successfully!!", data:student} if student.update(student_params) 
  #   render json: {errors: student.errors.full_messages}
  # end
 
  # def destroy
  #   student = @current_user.destroy   
  #   render json: { message: "Data of #{student.name} deleted successfully!" }
  # end
 
  # private
  # def student_params
  #   params.permit(:name, :email, :password, :type)
  # end
end
