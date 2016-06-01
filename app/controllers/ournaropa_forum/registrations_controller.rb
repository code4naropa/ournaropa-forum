require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class RegistrationsController < ApplicationController  
    
    # new sign up
    def new
    end

    # verify that email exists and has not yet signed up
    def verify
      
      # check if this email belongs to a permitted user
      @p_user = PermittedUser.find_by email: params[:email].downcase
      
      # if not permitted, then show error
      if @p_user.nil?
        render :email_not_found and return
      elsif @p_user.has_signed_up?
        render :already_signed_up and return
      end
      
    end

    # create the new user and send email to user with password reset instructions
    def create
      p_user = PermittedUser.find params[:p_user_id]
      
      # create new user on basis of permitted user
      user = User.create(
        first_name: p_user.first_name,
        last_name: p_user.last_name,
        email: p_user.email,
        role: p_user.role,
        seen_at: Time.now,
        is_superuser: p_user.is_superuser,
        is_developer: p_user.is_developer,
        reset_token: User.generate_reset_token,
        password: SecureRandom.uuid
      )
      
      # send email to the new user with instructions to reset password
      email = UserNotifier.send_signup_email(user)
      email.deliver_later
      
    end
    
  end
end
