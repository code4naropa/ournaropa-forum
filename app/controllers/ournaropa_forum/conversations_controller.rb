require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class ConversationsController < ApplicationController
    before_filter :authorize
    before_action :set_user
    before_action :set_conversation, only: [:show, :edit, :update, :destroy]
    
    # GET /conversations
    def index
      @conversations = Conversation.all
    end

    # GET /conversations/1
    def show
      @replies = @conversation.replies
      @reply = Reply.new
    end

    # GET /conversations/new
    def new
      @conversation = Conversation.new
    end

    # GET /conversations/1/edit
    def edit
    end

    # POST /conversations
    def create
      @conversation = Conversation.new(conversation_params)
      @conversation.author = @user

      if @conversation.save
        redirect_to @conversation, notice: 'Conversation was successfully created. You will receive email notifications about new replies.'
      else
        render :new
      end
    end

    # PATCH/PUT /conversations/1
    def update
      if @conversation.update(conversation_params)
        redirect_to @conversation, notice: 'Conversation was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /conversations/1
    def destroy
      @conversation.destroy
      redirect_to conversations_url, notice: 'Conversation was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conversation
        @conversation = Conversation.find(params[:id])
      end
    
      def set_user
        @user = current_user
      end

      # Only allow a trusted parameter "white list" through.
      def conversation_params
        params.require(:conversation).permit(:title, :body, :author_id)
      end
  end
end
