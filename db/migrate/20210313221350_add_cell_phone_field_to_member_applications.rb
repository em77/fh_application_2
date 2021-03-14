class AddCellPhoneFieldToMemberApplications < ActiveRecord::Migration[6.0]
  def change
    rename_column :member_applications, :phone_number, :phone_number_landline
    rename_column :member_applications, :phone_number_type, :phone_number_landline_type

    add_column :member_applications, :phone_number_cell, :string
    add_column :member_applications, :phone_number_cell_type, :string, default: "unknown"
  end
end
