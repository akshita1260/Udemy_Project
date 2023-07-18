class UsersController < ApiController
  skip_before_action :authenticate_user,only: [:login, :create]
  skip_before_action :check_instructor
  skip_before_action :check_student

  def create
    user = User.new(instructor_params)
    return render json: {message: "Hey #{user.name}, your account created successfully!!"} if user.save   
    render json: {errors: user.errors.full_messages}
    rescue ActiveRecord::SubclassNotFound
       render json: {message: "value of type must be useror or Student"}
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
    user = @current_user
    render json: user
  end

  def update
    user = @current_user
    return render json: {message: " Updated successfully!!", data:user} if user.update(instructor_params)  
    render json: {errors: user.errors.full_messages}
  end

  def destroy
    user = @current_user.destroy  
    render json: { message: "Data of #{user.name} deleted successfully!" }
  end

  private
  def instructor_params
    params.permit(:name, :email, :password, :type)
  end
end
