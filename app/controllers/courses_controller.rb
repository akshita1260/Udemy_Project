class CoursesController < ApplicationController
  before_action :authenticate_instructor, except: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action :authenticate_student,only: [:course_by_active_status,:course_by_category,:course_by_name_and_category]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def create
    course = @current_instructor.courses.new(course_params)
    course.video.attach(params[:video])
    if course.save
      render json: {message: course.video.url}
    else
      render json: {errors: course.errors.full_messages}  
    end
  end
 
  def index
    if course =  @current_instructor.courses
      render json: listing(course)
    else
      render json: {message: "name can't be empty"}
    end
  end
  
  def show
    course =@current_instructor.courses.find(params[:id])
    if course
    listing([course])
    end
    rescue ActiveRecord::RecordNotFound
      render json: {message: "no course find with #{params[:id]}"} 
  end

  def update
    course =@current_instructor.courses.find(params[:id])
    if course.update(course_params)
      listing([course])  
    end
    rescue ActiveRecord::RecordNotFound
     render json: {message: "no course find with #{params[:id]}"}  
  end

  def destroy
    course = @current_instructor.courses.find(params[:id])
    if course.destroy
      render json: { message: "Course deleted successfully!" }
    end
    rescue ActiveRecord::RecordNotFound
      render json: {message: "no course find with #{params[:id]}"}  
  end
  
  def course_by_name
    course=  @current_instructor.courses.where("name like ?", "%#{params[:name]}%")
    if course.empty?
      render json: {message: "No course found "}
    elsif  params[:name].blank?
      render json: {message: "name can't be empty"}
    else
      listing(course)
    end
  end

  def course_by_status
    course= @current_instructor.courses.where("status like ?", "%#{params[:status]}%")
    if course.empty?
      render json: {message: "No course found "}
    elsif params[:status].blank?
      render json: {message: "status can't be empty"}
    else
      listing(course)
    end
  end

  #STUDENT FUNCTIONALITY......
  def course_by_active_status
    course= Course.where("status == 'active'")
    if course.empty?
      render json: {message: "No course found "}
    else
    listing(course)
    end
  end

  def course_by_category
    result = []
    Category.find_each do |c1|
      c1.courses.each do |course_data|
        c = Hash.new
        c[:category_name] = c1.category_name
        c[:name] = course_data.name
        c[:description] = course_data.description
        c[:price] = course_data.price
        c[:status] = course_data.status
        result.push(c)
      end
    end
    render json: result
  end

  def course_by_name_and_category
    if (params[:name] || params[:category_name])&&(!params[:name].blank? || !params[:category_name].blank?)
      name = params[:name].strip if params[:name]
      category_name = params[:category_name].strip if params[:category_name] 

      enroll = ActiveRecord::Base.connection.execute("SELECT category_name,courses.id as course_id,courses.name,courses.description FROM courses INNER JOIN categories ON categories.id = courses.category_id WHERE name LIKE '%#{name}%' AND category_name LIKE '%#{category_name}%'")
      if enroll.empty?
        render json: {error: 'Record not found'}
      else
        render json: enroll
      end
    else
      render json: {message: "Please provide required field"}
    end
  end


  private
  def course_params
    params.permit(:name, :description, :status, :video, :price, :category_id)
  end

  def listing(course)
    result = []
    course.each do |course_data|
      c = Hash.new
      c[:name] = course_data.name
      c[:id] = course_data.id
      c[:description] = course_data.description
      c[:price] = course_data.price
      c[:status] = course_data.status
      c[:video] = course_data.video.url
      result.push(c)
    end
    render json: result
  end
end


