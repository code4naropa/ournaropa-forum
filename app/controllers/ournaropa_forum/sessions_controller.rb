require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class SessionsController < ApplicationController
    
    # render login form
    def new
    end

    # process login
    def create
      user = User.find_by_email(params[:email])
      
      # If the user exists AND the password entered is correct.
      if user && user.authenticate(params[:password])
        # Save the user id inside the browser cookie. This is how we keep the user 
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to root_path, notice: "Welcome back, " + user.name + "! Have a wonderful day :)" and return
      else
        # If user's login doesn't work, send them back to the login form.
        @login_failed = true
        render :new
      end
    end

    # logout
    def destroy
      session[:user_id] = nil
      redirect_to root_path and return
    end
    
  end
end
