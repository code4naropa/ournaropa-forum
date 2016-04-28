module OurnaropaForum
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    layout 'forum_scaffold'
  end
end
