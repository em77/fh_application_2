class AddApplicationStatusDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :member_applications, :application_status, 0
  end
end
