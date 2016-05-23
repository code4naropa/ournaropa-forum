require 'rails_helper.rb'

require "shared.rb"

feature 'Conversations' do 
  
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
  end
  
  scenario 'can create a conversation' do
    
    create_conversation
    
  end

end
