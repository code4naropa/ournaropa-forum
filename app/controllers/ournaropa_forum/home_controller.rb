require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class HomeController < ApplicationController
    
    # home screen
    def welcome
      
      # if user is logged in, show current conversations
      if current_user
        @conversations = Conversation.all.order(updated_at: :desc)
        render 'ournaropa_forum/conversations/index' and return
      end
    end
    
  end
end
