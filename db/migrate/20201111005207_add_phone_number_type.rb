class AddPhoneNumberType < ActiveRecord::Migration[6.0]
  def change
    add_column :member_applications, :phone_number_type, :string, default: "unknown"
  end
end
