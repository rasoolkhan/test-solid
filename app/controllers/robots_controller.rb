class RobotsController < ApplicationController
  caches_page :index

  def index
    robot_type = ENV['DISABLE_ROBOTS'] == 'true' ? 'staging' : 'production'
    robots = File.read(Rails.root + "config/robots/robots.#{robot_type}.txt")
    render text: robots, layout: false, content_type: 'text/plain'
  end
end
