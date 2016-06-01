require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class UsersController < ApplicationController
    before_filter :authorize

    # get all users for the directory in order of Staff, Current Students, and then Incoming Students
    def index
      @users = User.where(role: "Staff").order(first_name: :asc)
      @users += User.where(role: "Current Student").order(first_name: :asc)
      @users += User.where(role: "Incoming Student").order(first_name: :asc)
    end

  end
end
