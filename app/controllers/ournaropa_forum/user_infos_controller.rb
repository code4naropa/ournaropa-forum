require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class UserInfosController < ApplicationController
    before_action :set_user_info, only: [:show, :edit, :update, :destroy]

    # GET /user_infos
    def index
      @user_infos = UserInfo.all
    end

    # GET /user_infos/1
    def show
    end

    # GET /user_infos/new
    def new
      @user_info = UserInfo.new
    end

    # GET /user_infos/1/edit
    def edit
    end

    # POST /user_infos
    def create
      @user_info = UserInfo.new(user_info_params)

      if @user_info.save
        redirect_to @user_info, notice: 'User info was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /user_infos/1
    def update
      if @user_info.update(user_info_params)
        redirect_to @user_info, notice: 'User info was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /user_infos/1
    def destroy
      @user_info.destroy
      redirect_to user_infos_url, notice: 'User info was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user_info
        @user_info = UserInfo.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_info_params
        params.require(:user_info).permit(:hometown, :major, :age, :description, :show_email)
      end
  end
end
