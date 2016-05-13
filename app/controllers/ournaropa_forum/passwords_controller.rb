require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class PasswordsController < ApplicationController
    before_action :authorize, only: [:new, :update]
    before_action :set_user, only: [:new_after_reset, :update_after_reset]
    
    def forgot
    end

    def reset
      @error = "Please enter your email address." if params[:email].blank?
      render :forgot and return if @error
      
      @error = "We could not find a user with the email address you entered." unless User.exists?(email: params[:email])
      render :forgot and return if @error
      
      @user = User.find_by email: params[:email]
      @user.reset_token = User.generate_reset_token
      @user.save
      
      # send email
      UserNotifier.send_password_reset_email(@user, request.base_url).deliver_later
      
    end

    def new_after_reset
    end
    
    def update_after_reset
      redirect_to new_password_after_reset_path, notice: "Please enter a new password and confirm it by entering it again." and return if params[:password].blank? or params[:password_confirmation].blank?
        
      redirect_to new_password_after_reset_path, notice: "Password and password confirmation did not match." and return unless params[:password] == params[:password_confirmation]

      @user.password = params[:password]
      @user.reset_token = nil
      @user.save
      
      redirect_to login_path, notice: "Your password has been successfully updated."
    end
    
    def new
    end

    def update      
      
      @user = current_user
      
      redirect_to new_password_path, notice: "Your current password does not match what you entered." and return unless @user.authenticate params[:current_password]
      
      redirect_to new_password_path, notice: "Please enter a new password and confirm it by entering it again." and return if params[:password].blank? or params[:password_confirmation].blank?
        
      redirect_to new_password_path, notice: "Your new password and password confirmation did not match." and return unless params[:password] == params[:password_confirmation]

      @user.password = params[:password]
      @user.reset_token = nil
      @user.save
      
      redirect_to profile_path, notice: "Your password has been successfully updated."
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        
        redirect_to root_path, notice: "You are already logged in. To change your password go to Profile > Change Password." if current_user
        
        if not current_user
          @user = User.find(params[:id])
          redirect_to root_path, notice: "Sorry, your user ID and reset token did not match. Please check the url and try again." unless @user.reset_token == params[:reset_token]
        end
      end    
    
  end
end
