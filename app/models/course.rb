class Course < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrollments,dependent: :destroy
  has_one_attached :video 

  validates :name,:description,:status,:video,:price, presence: true
  validates :status, inclusion:{in: %w(active inactive )} 
  validates :name, uniqueness: {scope: :user_id,message: "ALERT :- You already create this course"}
  before_save :spaces

  def spaces
    self.name = name.strip()
  end
  

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "status", "updated_at", "user_id", "video"]
  end
   def self.ransackable_associations(auth_object = nil)
    ["category", "enrollments", "user", "video_attachment", "video_blob"]
  end

end
