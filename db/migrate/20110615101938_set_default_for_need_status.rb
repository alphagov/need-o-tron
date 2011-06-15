class SetDefaultForNeedStatus < ActiveRecord::Migration
  def up
    change_column_default :needs, :status, "new"
  end

  def down
    change_column_default :needs, :status, nil
  end
end