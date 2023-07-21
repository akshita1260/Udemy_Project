class CourseSerializer < ActiveModel::Serializer
  attributes :id,:category,:name,:description,:price,:status,:video
 
  def video
    object.video.url
  end

  def category
    object.category.category_name
  end

end
