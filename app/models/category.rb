class Category < ApplicationRecord
  has_many :courses, dependent: :destroy
  
  validates :category_name, presence: true,uniqueness: true
  before_save :spaces

  def spaces
    self.category_name = category_name.strip()
  end
end
