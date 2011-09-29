class AddWritingDeptFieldToNeeds < ActiveRecord::Migration
  def change
    add_column :needs, :writing_dept, :string
  end
end
