require 'spec_helper'

module OurnaropaForum
  describe Conversation, type: :model do
    
    before do
      @conversation = FactoryGirl.build(:ournaropa_forum_conversation)
    end
    
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:author_id) }
    
    it "has a valid factory" do
      expect(@conversation).to be_valid
    end
    
  end
end
