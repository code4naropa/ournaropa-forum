require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class SubscriptionsController < ApplicationController
    before_action :authorize
    before_filter :set_conversation, only: [:subscribe, :unsubscribe]
    before_action :set_user
    
    # show all subscriptions of user
    def index
      
    end
    
    def subscribe
      
      @conversation.subscriptions << @user unless @conversation.subscriptions.exists?(@user.id)
      @notice = "You will now receive email notifications about new replies in this conversation."
      
      respond_to do |format|
        format.html {
          redirect_to(@conversation, notice: @notice) and return
          return          
        }
        format.js
      end
      

    end

    def unsubscribe
      
      @conversation.subscriptions.delete(@user) if @conversation.subscriptions.exists?(@user.id)
      @notice = "You will now no longer receive email notifications about new replies in this conversation."
    
      respond_to do |format|
        format.html {
          redirect_to(@conversation, notice: @notice) and return
          return          
        }
        format.js
      end
    
    end
    
    private
    
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
    
    def set_user
      @user = current_user
    end
    
  end
end
