require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class ConversationsController < ApplicationController
    before_filter :authorize
    before_action :set_user
    before_action :set_conversation, only: [:show]
    
    # gets all conversations
    def index
      @conversations = Conversation.all
    end

    # gets a single conversation and associated replies
    def show
      @replies = @conversation.replies
      @reply = Reply.new
    end

    # begin a new convervsation
    def new
      @conversation = Conversation.new
    end

    # create the new conversation
    def create
      
      # init conversation and set its author
      @conversation = Conversation.new(conversation_params)
      @conversation.author = @user
      
      # prevent double posting
      redirect_to conversation_path(Conversation.where(:author_id => @conversation.author.id).recent.where(:title => @conversation.title).take) and return unless @conversation.is_not_a_double_post?

      # redirect user to the new conversation or take user back to form if errors exist
      if @conversation.save
        redirect_to @conversation, notice: 'Conversation was successfully created. You will receive email notifications about new replies.'
      else
        render :new
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conversation
        @conversation = Conversation.friendly.find(params[:id])
      end
    
      # set @user variable to the currently logged in user
      def set_user
        @user = current_user
      end

      # Only allow a trusted parameter "white list" through.
      def conversation_params
        params.require(:conversation).permit(:title, :body)
      end
  end
end
