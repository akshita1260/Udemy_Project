class CoursesController < ApiController
  before_action :authorization
  before_action :show_through_id, only: [:update, :show, :destroy]

  def create
    course = @current_user.courses.new(course_params)
    return  render json: {message: course.video.url} if course.save
    render json: {errors: course.errors.full_messages}  
  end

  def index
    if @current_user.type == "Instructor"
      if params[:search_by].present?
        course = @current_user.courses.where("name like ? or status like ?", params[:search_by].strip+"%",params[:search_by].strip+"%")
        return render json: {message: "No course found "} if course.empty?
        render json: course 
      else
        render json: @current_user.courses.all
      end
    else
      search()
    end
  end

  def show
     render json: @course 
  end

  def update   
    if @course.update(course_params)
     render json: @course  
    else
      render json: {errors: @course.errors.full_messages}
    end
  end

  def destroy
    @course.destroy
    render json: { message: "Course deleted successfully!" } 
  end

  private

  def course_params
    params.permit(:name, :description, :status, :video, :price, :category_id)
  end

  def show_through_id
    @course =@current_user.courses.find_by_id(params[:id])
    unless @course.present?
      render json: { message: "no course found with this id"}
    end
  end

  def search
    if params[:search_by].present? 
      name = params[:search_by].strip if params[:search_by]
      course = Course.joins(:category).where("name like '%#{params[:search_by]}%' or category_name like '%#{params[:search_by]}%' and status='active'")
      return render json: { error: 'Record not found' } if course.empty?
      render json: course
    else
      render json: { message: 'Please provide required field' }
    end
  end

  def authorization
    authorize Course
  end
end
