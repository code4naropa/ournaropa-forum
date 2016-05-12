require 'rails_helper'

module OurnaropaForum
  RSpec.describe PermittedUser, type: :model do
 
    before do
      @permitted_user = OurnaropaForum::PermittedUser.new FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    end    
    
    it "saves email as lowercase" do
      email = "ABC@ABC.COM"
      
      @permitted_user.email = email
      
      @permitted_user.save
      
      expect(@permitted_user.email).to eq(email.downcase)
    end

  end
end
