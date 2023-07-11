class AddColumnsToEnrollment < ActiveRecord::Migration[7.0]
  def change
    add_column :enrollments, :status, :string
    add_reference :enrollments, :course, null: false, foreign_key: true
    add_reference :enrollments, :user, null: false, foreign_key: true
  end
end
