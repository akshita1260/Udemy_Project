class AddColumnToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :price, :integer
  end
end
