class UsersController < ApiController
  skip_before_action :authenticate_user,only: [:login, :create]
  # skip_before_action :check_instructor
  # skip_before_action :check_student

  def create
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: {message: "Hey #{user.name}, your account created successfully!!", token: token} 
    else
      render json: {errors: user.errors.full_messages}
    end
      rescue ActiveRecord::SubclassNotFound
      render json: {message: "value of type must be Instructor or Student"}
  end

  def login
    user =User.find_by(email: params[:email],password: params[:password])
    if user
      token = jwt_encode(user_id: user.id)
      render json: {message: "#{user.name} you logged in successfully...",token: token}, status: :ok
    else
      render json: {message: "Invalid email and password"}
    end
  end

  def show
    render json: @current_user
  end

  def update
    return render json: {data: @current_user} if  @current_user.update(user_params)  
    render json: {errors:  @current_user.errors.full_messages}
  end

  def destroy
    user = @current_user.destroy  
    render json: { message: "Data of #{user.name} deleted successfully!" }
  end

  private
  def user_params
    params.permit(:name, :email, :password, :type)
  end
end
