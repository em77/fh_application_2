class MemberApplicationsController < ApplicationController
  def new
    @member_application = MemberApplication.new
  end
end
