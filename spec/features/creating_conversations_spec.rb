require 'rails_helper.rb'

require "shared.rb"

feature 'Conversations' do 
  
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
  end
  
  scenario 'can create a conversation' do
    
    title = 'Test Conversation' 
    body = "Lorem Ipsum Dolorem\n" * 10
    
    visit '/forum'
    click_link 'Start A Conversation'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_button 'Create Conversation'
    
    expect(page).to have_content(title)
    expect(page).to have_content(body)
    
    @user.conversations.reload
    
    expect(@user.conversations.count).to eq(1)
    
    @conversation = OurnaropaForum::Conversation.first
    expect(@conversation.author).to be_present
  end
end
