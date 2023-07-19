class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  
  validates :name,format: {with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/},presence: true
  validates :email ,uniqueness: true,format: {with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.+[a-z]{2,3}/},presence: true
  validates :password, length: {minimum: 8},format: {with: /\A\S+\z/},presence: true
  validates :type,presence: true

 def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password", "type", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["courses", "enrollments"]
  end
end
