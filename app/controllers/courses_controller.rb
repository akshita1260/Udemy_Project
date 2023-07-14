class CoursesController < ApplicationController
  before_action :authenticate_user
  before_action :check_instructor, except: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action :check_student,only: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def create
    course = @current_user.courses.new(course_params)
    course.video.attach(params[:video])
    return  render json: {message: course.video.url} if course.save
    render json: {errors: course.errors.full_messages}  
  end
 
  def index
    course =  @current_user.courses
    return render json: {message: "No course found "} if course.empty?
    render json: course
  end
  
  def show
    course =@current_user.courses.find(params[:id])
    return render json: course if course
    rescue ActiveRecord::RecordNotFound
    render json: {message: "no course find with #{params[:id]}"} 
  end

  def update
    course =@current_user.courses.find(params[:id])
    return render json: course  if course.update(course_params)
    rescue ActiveRecord::RecordNotFound
    render json: {message: "no course find with #{params[:id]}"}  
  end

  def destroy
    course = @current_user.courses.find(params[:id])
    return render json: { message: "Course deleted successfully!" } if course.destroy
    rescue ActiveRecord::RecordNotFound
    render json: {message: "no course find with #{params[:id]}"}  
  end
  
  def course_by_name
 
    course=  @current_user.courses.where("name like '%#{params[:name]}%'")
    return render json: {message: "No course found "} if course.empty?
    return render json: {message: "name can't be empty"}if params[:name].blank?
    render json: course  
  end

  def course_by_status
 
    course= @current_user.courses.where("status like '%#{params[:status]}%'")
    return render json: {message: "No course found "} if course.empty?
    return render json: {message: "status can't be empty"} if params[:status].blank?
    render json: course
  end

 
  #STUDENT FUNCTIONALITY......
  def course_by_active_status
    course= Course.where("status = 'active'")
    return render json: {message: "No course found "} if course.empty?
    render json: course
  end

  def course_by_category
    course = Course.joins(:category).where("category_name like '%#{params[:category_name]}%' and status='active'")
    return render json: {error: 'Record not found'} if course.empty?
    return render json: {message: " category_name can't be empty"} if params[:category_name].blank?
    render json: course
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
end


