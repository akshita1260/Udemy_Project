class Category < ApplicationRecord
  has_many :courses, dependent: :destroy
  validates :name, presence: true,uniqueness: true
  before_save :spaces

  def spaces
    self.name = name.strip()
  end
end
