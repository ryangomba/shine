require 'api/wunderground'
require 'api/urban_airship'

class Badge < ActiveRecord::Base

  validates_presence_of :ua_id, :latitude, :longitude
  validates_uniqueness_of :ua_id

  def enqueue(job)
    puts 'Enqueued'
  end

  def before
    puts 'Before'
  end

  def perform
    puts 'Performing'
    current_temp = Wunderground.current_temp(self.latitude, self.longitude)
    push_success = UrbanAirship.push_badge(self.ua_id, current_temp)
    if not push_success
      raise 'Push notification could not be sent'
    end
  end
  
  def after
    puts 'After'
  end
  
  def success(job)
    puts 'Success'
    puts 'Enqueuing next job...'
    self.last_push = DateTime.now
    self.next_job = Delayed::Job.enqueue(self, 0, 15.minutes.from_now).id
    self.save()
  end
  
  def error
    puts 'Error'
  end
  
  def failure
    puts 'FAILURE'
  end

end