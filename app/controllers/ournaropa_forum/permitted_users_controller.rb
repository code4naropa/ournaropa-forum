require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class PermittedUsersController < ApplicationController
    before_filter :authorize_superuser
    before_action :set_permitted_user, only: [:show, :edit, :update, :destroy]

    # GET /permitted_users
    def index
      @permitted_users = PermittedUser.all
    end

    # GET /permitted_users/1
    def show
    end

    # GET /permitted_users/new
    def new
      @permitted_user = PermittedUser.new
    end

    # GET /permitted_users/1/edit
    def edit
    end

    # POST /permitted_users
    def create
      @permitted_user = PermittedUser.new(permitted_user_params)

      if @permitted_user.save
        
        # send email
        email = UserNotifier.send_invitation_email(@permitted_user, current_user)
        email.deliver_later
        
        redirect_to permitted_users_path, notice: 'Access granted. Email invitation successfully sent.'
      else
        render :new
      end
    end

    # PATCH/PUT /permitted_users/1
    def update
      if @permitted_user.update(permitted_user_params)
        redirect_to @permitted_user, notice: 'Permitted user was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /permitted_users/1
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
