class RenameNameToCategoryName < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :name, :category_name
  end
end
