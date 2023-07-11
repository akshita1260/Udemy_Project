class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  
  validates :name,format: {with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*[a-zA-Z]\z/},presence: true
  validates :email ,uniqueness: true,format: {with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.+[a-z]{2,3}/},presence: true
  validates :password, length: {minimum: 8},format: {with: /\A\S+\z/},presence: true


end
