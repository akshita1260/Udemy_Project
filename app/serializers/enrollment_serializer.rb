class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id,:status,:course

  def course
    object.course.name
  end
  
end
