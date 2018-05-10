class AdminController < ApplicationController

  def index
    @badges = Badge.all
    @jobs = Delayed::Job.all
  end

end