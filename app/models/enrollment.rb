class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: {scope: :user_id,message: "ALERT :- You already enroll in this course"}
end
