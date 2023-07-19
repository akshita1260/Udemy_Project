class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: {scope: :user_id,message: "ALERT :- You already enroll in this course"}
  
  def self.ransackable_attributes(auth_object = nil)
    ["course_id", "created_at", "id", "status", "updated_at", "user_id"]
  end

end
