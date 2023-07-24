class EnrollmentsController < ApiController
  before_action :show_through_id,only: [:show,:destroy,:update]
  before_action :authorization
  def create
    course = Course.find(params[:course_id])
    if course.status == 'active'
      enroll = @current_user.enrollments.new(enroll_params)
      if enroll.save
        enroll.update(status: 'started')
        render json: enroll
      else
        render json: enroll.errors.full_messages
      end
    else
      render json: { message: "can't enroll inactive course" }
    end
    rescue ActiveRecord::RecordNotFound
      render json: { message: "No record found with this id"}
  end

   def index
    if params[:name].present?
      name = params[:name].strip if params[:name]
      enroll = @current_user.enrollments.joins(:course).where("name LIKE '%#{name}%'")
      return render json: {error: 'Record not found'} if enroll.empty?
      render json: enroll
    else
      render json: @current_user.enrollments.all
    end
  end

  def show
    render json: @enroll 
  end

  def destroy
    @enroll.destroy
    render json: {message: "Deleted successfully...."}
  end

  def update
    if @enroll.update(status: 'completed') 
      render json: {message: 'congartulations!! Your course is completed ', data: @enroll}
    else
      render json: {errors: @course.errors.full_messages}
    end
  end

  private
  def enroll_params
    params.permit( :course_id)
  end 

  def show_through_id()
    @enroll =@current_user.enrollments.find_by_id(params[:id])
    unless @enroll.present?
      render json: {message: "no course found with this id"}
    end
  end

  def authorization
    authorize Enrollment
  end
end
