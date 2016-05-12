require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class HomeController < ApplicationController
    def welcome
      if current_user
        @conversations = Conversation.all
        render 'ournaropa_forum/conversations/index'
      end
    end
  end
end
