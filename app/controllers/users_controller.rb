class UsersController < ApplicationController
	# skip_before_action :authenticate_user,only: [:login, :create]
  # # skip_before_action :check_instructor,only: [:login, :create]
  # # skip_before_action :check_student

  # def create
  #   instruct = User.new(instructor_params)
  #   return render json: {message: "Hey #{instruct.name}, your account created successfully!!"} if instruct.save   
  #   render json: {errors: instruct.errors.full_messages}
  # end

  # def login
  #   instruct =User.find_by(email: params[:email],password: params[:password])
  #   if instruct
  #     token = jwt_encode(user_id:  user.id)
  #     render json: {message: "#{instruct.name} you logged in successfully...",token: token}, status: :ok
  #   else
  #     render json: {message: "Invalid email and password"}
  #   end
  # end

  # def instructor_params
  #   params.permit(:name, :email, :password, :type)
  # end

end
