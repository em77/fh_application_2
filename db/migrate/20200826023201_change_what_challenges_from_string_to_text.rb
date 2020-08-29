class ChangeWhatChallengesFromStringToText < ActiveRecord::Migration[6.0]
  def change
    change_column :member_applications, :what_challenges, :text
  end
end
