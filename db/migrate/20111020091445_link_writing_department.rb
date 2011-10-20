class LinkWritingDepartment < ActiveRecord::Migration
  def up
    add_column :needs, :writing_department_id, :integer
    Need.reset_column_information
    Need.find_each do |need|
      if need.writing_dept.present?
        need.writing_department = Department.find_or_create_by_name(need.writing_dept)
        need.save
      end
    end
    remove_column :needs, :writing_dept
  end

  def down
    remove_column :needs, :writing_department_id
    add_column :needs, :writing_dept
  end
end