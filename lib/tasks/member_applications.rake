namespace :member_applications do
  desc "Destroy expired applications"
  task destroy_expired: :environment do
    today = Time.current.in_time_zone("Eastern Time (US & Canada)").to_date
    counter = 0
    MemberApplication.where("application_expiration_date <= ?", today).each do |member_app|
      member_app.destroy
      counter += 1
    end
    puts "#{counter} expired application(s) destroyed\n"
  end

end
