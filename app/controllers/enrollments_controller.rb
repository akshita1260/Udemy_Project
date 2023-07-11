class EnrollmentsController < ApplicationController
  # skip_before_action :authenticate_instructor
  before_action :authenticate_student


  def create
    enroll = @current_student.enrollments.new(enroll_params)
    if enroll.save
      enroll.update(status: 'started')
      render json: enroll
    else
      render json: enroll.errors.full_messages
    end
  end

  def index
    enroll = Enrollment.all
    render json: enroll
  end

  def show
   enroll = Enrollment.find(params[:id])
   render json: enroll
  end

  def destroy
    enroll = Enrollment.find(params[:id])
    if enroll.destroy
      render json: { message: "enrollment cancle" }
    else
      render json: { errors: student.errors.full_messages }
    end
    
  end

  def update_student_course_status
    enroll = @current_student.enrollments.find(params[:id])
    if enroll
      enroll.update(status: 'completed')
      render json: {message: 'congartulations!! Your course is completed '}
    end
    rescue ActiveRecord::RecordNotFound
      render json: {message: "no course find with #{params[:id]}"} 
  end

  def search_in_my_course
    if (params[:name] || params[:status])&&(!params[:name].blank? || !params[:status].blank?)
      name = params[:name].strip if params[:name]
      status = params[:status].strip if params[:status] 

      enroll = ActiveRecord::Base.connection.execute("SELECT enrollments.id as enrollment_id,course_id,courses.name,enrollments.status FROM courses INNER JOIN enrollments ON enrollments.course_id = courses.id INNER JOIN users ON users.id=enrollments.user_id WHERE enrollments.user_id=#{@current_student.id} AND enrollments.status LIKE '%#{status}%' AND courses.name LIKE '%#{name}%'")
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
  def enroll_params
    params.permit( :course_id)
  end 

  
end
