module OurnaropaForum
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    # force secure connection
    force_ssl unless: -> { Rails.env.in? ['development', 'test'] }
    
    # get the user who is currently signed in
    def current_user
      
      if session[:user_id]
        redirect_to(logout_path) and return unless User.exists?(session[:user_id])
      end
      
      @current_user ||= User.find(session[:user_id]) if session[:user_id]    
      
    end
    helper_method :current_user

    # checks whether user is signed in
    def authorize
      redirect_to login_path and return unless current_user
      @current_user.touch(:seen_at)
    end
    
    # checks whether user is signed in and has superuser privileges
    def authorize_superuser
      authorize
      redirect_to root_path and return unless current_user.is_superuser
    end
    
    
  end
end
