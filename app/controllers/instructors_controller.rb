class InstructorsController < ApiController
  # skip_before_action :authenticate_user,only: [:login, :create]
  # skip_before_action :check_instructor,only: [:login, :create]
  # skip_before_action :check_student

  # def create
  #   instruct = User.new(instructor_params)
  #   return render json: {message: "Hey #{instruct.name}, your account created successfully!!"} if instruct.save   
  #   render json: {errors: instruct.errors.full_messages}
  # end

  # def login
  #   instruct =User.find_by(email: params[:email],password: params[:password])
  #   if instruct
  #     token = jwt_encode(user_id:  instruct.id)
  #     render json: {message: "#{instruct.name} you logged in successfully...",token: token}, status: :ok
  #   else
  #     render json: {message: "Invalid email and password"}
  #   end
  # end

  # def show
  #   instruct = @current_user
  #   render json: instruct
  # end

  # def update
  #   instruct = @current_user
  #   return render json: {message: " Updated successfully!!", data:instruct} if instruct.update(instructor_params)  
  # end

  # def destroy
  #   instruct = @current_user.destroy  
  #   render json: { message: "Data of #{instruct.name} deleted successfully!" }
  # end

  # private
  # def instructor_params
  #   params.permit(:name, :email, :password, :type)
  # end

end
