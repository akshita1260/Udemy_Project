class EnrollmentsController < ApplicationController
  before_action :authenticate_user
  skip_before_action :check_instructor
  before_action :check_student

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
    enroll = Enrollment.all
    return render json: {message: "No course found "} if enroll.empty?
    render json: enroll
  end

  def show
    enroll = Enrollment.find(params[:id])
    return render json: enroll if enroll
    rescue ActiveRecord::RecordNotFound
    render json: {message: "no course find with #{params[:id]}"} 
  end

  def destroy
    enroll = Enrollment.find(params[:id])
    return render json: { message: "enrollment cancle" } if enroll.destroy
    render json: { errors: student.errors.full_messages }
  end

  def update_student_course_status
    enroll = @current_user.enrollments.find(params[:id])
    if enroll
      enroll.update(status: 'completed') 
      render json: {message: 'congartulations!! Your course is completed '}
    end
    rescue ActiveRecord::RecordNotFound
    render json: {message: "no course find with #{params[:id]}"} 
  end

  def search_in_my_course
    if (params[:name].present? || params[:status].present?)
      name = params[:name].strip if params[:name]
      status = params[:status].strip if params[:status] 

      enroll = @current_user.enrollments.joins(:course).where("enrollments.status LIKE '%#{status}%' AND name LIKE '%#{name}%'")
      return render json: {error: 'Record not found'} if enroll.empty?
      render json: enroll
    else
      render json: {message: "Please provide required field"}
    end
  end

  private
  def enroll_params
    params.permit( :course_id)
  end 
end
