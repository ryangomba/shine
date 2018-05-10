class BadgesController < ApplicationController
  
  def index
    @badges = Badge.all
    render json: @badges
  end
  
  def create
    @badge = Badge.find_by_ua_id(params[:badge][:ua_id])
    if @badge.nil? then @badge = Badge.new end
    @badge.update_attributes(params[:badge])
    if @badge.errors.empty?
      @badge.next_job = Delayed::Job.enqueue(@badge).id
      @badge.save()
      render json: @badge, status: 201
    else
      puts @badge.errors.inspect
      render json: { errors: @badge.errors }, status: 400
    end
  end
  
  def destroy
    @badge = Badge.find_by_ua_id(params[:id])
    if @badge and @badge.next_job
      next_job = Delayed::Job.find_by_id(@badge.next_job)
      if next_job then next_job.delete end
      @badge.destroy()
      render json: { status: "destroyed" }
    else
      render json: { error: 'resource not found' }, status: 404
    end
  end
  
end