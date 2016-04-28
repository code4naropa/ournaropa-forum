require_dependency "ournaropa_forum/application_controller"

module OurnaropaForum
  class RepliesController < ApplicationController
    before_action :set_conversation
    before_action :set_reply, only: [:show, :edit, :update, :destroy]
    
    # GET /replies
    def index
      @replies = Reply.where(:conversation => @conversation)
    end

    # GET /replies/1
    def show
    end

    # GET /replies/new
    def new
      @reply = Reply.new
    end

    # GET /replies/1/edit
    def edit
    end

    # POST /replies
    def create
      @reply = Reply.new(reply_params)
      @reply.conversation = @conversation

      if @reply.save
        redirect_to [@conversation, @reply], notice: 'Reply was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /replies/1
    def update
      if @reply.update(reply_params)
        redirect_to [@conversation, @reply], notice: 'Reply was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /replies/1
    def destroy
      @reply.destroy
      redirect_to conversation_replies_url, notice: 'Reply was successfully destroyed.'
    end

    private
    
      def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
    
      # Use callbacks to share common setup or constraints between actions.
      def set_reply
        @reply = Reply.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def reply_params
        params.require(:reply).permit(:title, :body, :author_id, :conversation_id)
      end
  end
end
