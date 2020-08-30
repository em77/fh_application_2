class CreateApplicationLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :application_logs do |t|

      t.timestamps
    end
  end
end
