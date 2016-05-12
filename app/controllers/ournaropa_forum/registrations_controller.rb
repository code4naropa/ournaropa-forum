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
      @user.name = p_user.name
      @user.email = p_user.email
      #@user.role = p_user.role
      @user.password = SecureRandom.uuid  
      
      @user.save
      
      # send email
      
      
    end
  end
end
