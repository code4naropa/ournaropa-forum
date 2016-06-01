require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class PasswordsController < ApplicationController
    before_action :authorize, only: [:new, :update]
    before_action :set_user, only: [:new_after_reset, :update_after_reset]
    
    # render forgot password form
    def forgot
    end

    # resets user's password and sends them an email so they can set a new one
    def reset
      
      # make sure an email address was entered
      @error = "Please enter your email address." if params[:email].blank?
      render :forgot and return if @error
      
      # make sure we have a user with that email address
      @error = "We could not find a user with the email address you entered." unless User.exists?(email: params[:email])
      render :forgot and return if @error
      
      # fetch user from database and set new reset token
      user = User.find_by email: params[:email]
      user.reset_token = User.generate_reset_token
      user.save
      
      # send email to the user
      email = UserNotifier.send_password_reset_email(user)
      email.deliver_later
    end

    # render form for setting new password
    def new_after_reset
    end
    
    # update password of user based on their ID and reset token
    def update_after_reset
      
      # make sur that passwords are not blank
      redirect_to new_password_after_reset_path, notice: "Please enter a new password and confirm it by entering it again." and return if params[:password].blank? or params[:password_confirmation].blank?
      
      # make sure that passwords match
      redirect_to new_password_after_reset_path, notice: "Password and password confirmation did not match." and return unless params[:password] == params[:password_confirmation]

      # save new password and delete reset token
      @user.password = params[:password]
      @user.reset_token = nil
      @user.save
      
      # redirect user to login path
      redirect_to login_path, notice: "Your password has been successfully updated."
    end
    
    # render form to set a new password
    def new
    end

    # update password
    def update      
      
      @user = @current_user
      
      # make sure curent password is correct
      redirect_to new_password_path, notice: "Your current password does not match what you entered." and return unless @user.authenticate params[:current_password]
      
      # make sure that new passwords are not blank
      redirect_to new_password_path, notice: "Please enter a new password and confirm it by entering it again." and return if params[:password].blank? or params[:password_confirmation].blank?
        
      # make sure that new passwords match each other
      redirect_to new_password_path, notice: "Your new password and password confirmation did not match." and return unless params[:password] == params[:password_confirmation]

      # save new password and delete reset token
      @user.password = params[:password]
      @user.reset_token = nil
      @user.save
      
      # redirect user to profile path
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
