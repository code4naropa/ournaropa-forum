require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class ProfileController < ApplicationController
    before_filter :authorize    
    before_action :set_user
    
    # render profile
    def edit
    end
    
    # update profile
    def update      
      if @user.info.update_attributes(user_info_params)
        redirect_to profile_path, notice: 'Your profile was successfully updated.'
      else
        @user.info.avatar = nil if @user.info.errors.messages.include?(:avatar)
        render :edit
      end
    end
    
    private
    
    def set_user
      @user = current_user
    end
    
    # Only allow a trusted parameter "white list" through.
    def user_info_params
      params.require(:user_info).permit(:first_name, :last_name, :hometown, :major, :age, :description, :share_email, :avatar)
    end
    
  end
end
