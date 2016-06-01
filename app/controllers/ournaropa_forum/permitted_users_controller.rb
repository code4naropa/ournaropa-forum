require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class PermittedUsersController < ApplicationController
    before_filter :authorize_superuser
    before_action :set_permitted_user, only: [:destroy]

    # list all permitted users
    def index
      @permitted_users = PermittedUser.all
    end

    # form for a new permitted user
    def new
      @permitted_user = PermittedUser.new
    end

    # create the new permitted user
    def create
      @permitted_user = PermittedUser.new(permitted_user_params)

      if @permitted_user.save
        
        # send email invitation to new permitted user
        email = UserNotifier.send_invitation_email(@permitted_user, current_user)
        email.deliver_later
        
        redirect_to permitted_users_path, notice: 'Access granted. Email invitation successfully sent.'
      else
        render :new
      end
    end

    # delete user
    def destroy
      
      if @permitted_user.destroy
        redirect_to permitted_users_url, notice: 'Access successfully revoked.'
      else
        redirect_to permitted_users_url, notice: 'Failed: User has already signed up.'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_permitted_user
        @permitted_user = PermittedUser.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def permitted_user_params
        params.require(:permitted_user).permit(:email, :first_name, :last_name, :role)
      end
  end
end
