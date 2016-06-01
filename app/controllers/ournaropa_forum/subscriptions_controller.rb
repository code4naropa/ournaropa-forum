require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class SubscriptionsController < ApplicationController
    before_action :authorize
    before_filter :set_conversation, only: [:subscribe, :unsubscribe, :destroy]
    before_action :set_user
    
    # show all subscriptions of user
    def index
      @subscriptions = @user.subscriptions.order(updated_at: :desc)
    end
    
    # subscribe user to a conversation
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

    # unsubscribe user from a conversation
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
    
    # enable inactivity emails that are sent after 7 days of inactivity
    def enable_inactivity_email
      @user.update_attributes(:is_receiving_inactivity_email => true)
      @notice = "You have enabled inactivity notifications."
      
      respond_to do |format|
        format.html {
          redirect_to(manage_email_notifications_path, notice: @notice) and return
          return          
        }
        format.js {
          render :subscribe
        }

      end
    end
    
    # dsiable inactivity emails that are sent after 7 days of inactivity
    def disable_inactivity_email
      @user.update_attributes(:is_receiving_inactivity_email => false)
      @notice = "You have disabled inactivity notifications."
      
      respond_to do |format|
        format.html {
          redirect_to(manage_email_notifications_path, notice: @notice) and return
          return          
        }
        format.js {
          render :unsubscribe
        }
      end
    end
    
    # disable subscription
    def destroy
      
      @conversation.subscriptions.delete(@user) if @conversation.subscriptions.exists?(@user.id)
      @notice = "You will now no longer receive email notifications about new replies in '#{@conversation.title}'."
    
      redirect_to manage_email_notifications_path      
      
    end
    
    # disable all subscriptions
    def destroy_all
      @user.subscriptions.each do |subscription|
        subscription.subscriptions.delete(@user)
      end
      
      @notice = "All notifications about new replies in conversations disabled."
      
      redirect_to manage_email_notifications_path and return     
    end
    
    private
    
    def set_conversation
      @conversation = Conversation.friendly.find(params[:conversation_id])
    end
    
    def set_user
      @user = current_user
    end
    
  end
end
