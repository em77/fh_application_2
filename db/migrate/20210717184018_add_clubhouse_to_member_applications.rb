class AddClubhouseToMemberApplications < ActiveRecord::Migration[6.0]
  def change
    add_reference :member_applications, :clubhouse
  end
end
