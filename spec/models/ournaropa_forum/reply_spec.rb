require 'spec_helper'

module OurnaropaForum
  describe Reply, type: :model do
    
    before do
      @reply = FactoryGirl.build(:ournaropa_forum_reply)
      @reply.conversation = OurnaropaForum::Conversation.create! FactoryGirl.attributes_for(:ournaropa_forum_conversation)
    end
    
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:author_id) }
    it { is_expected.to validate_presence_of(:conversation) }
    
    it "has a valid factory" do
      expect(@reply).to be_valid
    end
    
    it "is part of a conversation" do
      expect(@reply.conversation).to be_present
    end
    
  end
end
