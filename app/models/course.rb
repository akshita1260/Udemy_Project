class Course < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrollments
  has_one_attached :video 

  validates :name,:description,:status,:video,:price, presence: true
  validates :status,inclusion:{in: %w(active inactive )} 
  validates :name, uniqueness: {scope: :user_id,message: "ALERT :- You already create this course"}
  before_save :spaces

  def spaces
    self.name = name.strip()
  end
  


end
