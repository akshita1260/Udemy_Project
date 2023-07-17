class CoursesController < ApiController
  before_action :authenticate_user
  before_action :check_instructor, except: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action :check_student,only: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action :search_by_activestatus_and_category,only: [:course_by_active_status,:course_by_category]
  before_action :show_through_id,only: [:update,:show,:destroy]

  def create
    course = @current_user.courses.new(course_params)
    course.video.attach(params[:video])
    return  render json: {message: course.video.url} if course.save
    render json: {errors: course.errors.full_messages}  
  end

  def index
    if params[:name].present?
      course = @current_user.courses.where("name like '%#{params[:name]}%'")
      return render json: {message: "No course found "} if course.empty?
      render json: course 
    else
      render json: {message: "name can't be empty"}#if params[:name].present?
    end
  end

  def show
     render json: @course 
  end

  def update   
    if @course.update(course_params)
     render json: @course  
    end
  end

  def destroy
     @course.destroy
     render json: { message: "Course deleted successfully!" } 
  end
  
  def course_by_status
    course= @current_user.courses.where("status like '%#{params[:status]}%'")
    return render json: {message: "No course found "} if course.empty?
    return render json: {message: "status can't be empty"} if params[:status].blank?
    render json: course
  end

  #.........STUDENT FUNCTIONALITY......
  def course_by_active_status
    
  end

  def course_by_category
    
  end

  def course_by_name_and_category
    if (params[:name].present? || params[:category_name].present?)
      name = params[:name].strip if params[:name]
      category_name = params[:category_name].strip if params[:category_name] 
      enroll = Course.joins(:category).where("name like '%#{name}%' and category_name like '%#{category_name}%' and status='active'")
      return render json: {error: 'Record not found'} if enroll.empty?
      render json: enroll
    else
      render json: {message: "Please provide required field"}
    end
  end

  private
  def course_params
    params.permit(:name, :description, :status, :video, :price, :category_id)
  end

  def search_by_activestatus_and_category
     course = Course.joins(:category).where("category_name like '%#{params[:category_name]}%' and status =='active'")
    return render json: {error: 'Record not found'} if course.empty?
    return render json: {message: " category_name can't be empty"} unless params[:category_name].present?
    render json: course
  end

  def show_through_id()
     @course =@current_user.courses.find_by_id(params[:id])
     unless @course.present?
      render json: {message: "no user found with this id"}
    end
  end
end


