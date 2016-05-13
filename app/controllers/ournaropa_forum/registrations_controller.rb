require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class RegistrationsController < ApplicationController  
    
    def new
    end

    def verify
      
      # check if this email belongs to a permitted user
      @p_user = PermittedUser.find_by email: params[:email].downcase
      
      # if not permitted, then show error
      if @p_user.nil?
        render :email_not_found
      end
      
      
    end

    def create
      p_user = PermittedUser.find params[:p_user_id]
      
      @user = User.new
      @user.first_name = p_user.first_name
      @user.last_name = p_user.last_name
      @user.email = p_user.email
      @user.role = p_user.role
      @user.reset_token = User.generate_reset_token
      @user.password = SecureRandom.uuid  
      
      @user.save
      
      # send email
      UserNotifier.send_signup_email(@user, request.base_url).deliver_later
      
    end
  end
end
