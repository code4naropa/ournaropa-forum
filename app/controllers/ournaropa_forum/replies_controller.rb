require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class RepliesController < ApplicationController
    before_filter :authorize
    before_action :set_conversation
    before_action :set_user
    
    # create new reply
    def create
      @reply = Reply.new(reply_params)
      @reply.conversation = @conversation
      @reply.author = @user
      
      # prevent double posting
      redirect_to conversation_path(Reply.where(:author_id => @reply.author.id).recent.where(:body => @reply.body).take.conversation) and return unless @reply.is_not_a_double_post?

      if @reply.save
        
        # check subscriptions for this conversation and email everyone who is subscribed
        @reply.conversation.subscriptions.each do |sub|
          if sub.id != @reply.author.id
            email = UserNotifier.send_new_reply_email(sub, @reply)
            email.deliver_later
          end
        end
        
        # add a subscription notice 
        @subscription_notice = "Reply successfully posted."
        @subscription_notice += " You will receive email notifications about new replies in this conversation." if @reply.author.is_subscribed_to?(@conversation)
        
        redirect_to @conversation, notice: @subscription_notice
        
      else # else go back to form
        @replies = @conversation.replies
        render 'ournaropa_forum/conversations/show' and return
      end
    end

    private
    
    # sets current conversation
    def set_conversation
      @conversation = Conversation.friendly.find(params[:conversation_id])
    end

    # sets current user
    def set_user
      @user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def reply_params
      params.require(:reply).permit(:body)
    end
  end
end
