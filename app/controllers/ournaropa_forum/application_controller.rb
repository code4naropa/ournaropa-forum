module OurnaropaForum
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    def current_user
      
      if session[:user_id]
        redirect_to(logout_path) and return unless User.exists?(session[:user_id])
      end
      
      @current_user ||= User.find(session[:user_id]) if session[:user_id]    
      
    end
    helper_method :current_user

    def authorize
      redirect_to login_path and return unless current_user
      @current_user.touch(:seen_at)
    end
    
    def authorize_superuser
      authorize
      
      redirect_to root_path and return unless current_user.is_superuser
    end
    
    
  end
end
