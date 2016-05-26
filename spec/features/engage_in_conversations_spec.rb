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
  
  scenario 'can create a reply' do
    
    create_conversation
    create_reply @conversation.id
    
  end
  
  scenario 'user tries to create the same conversation twice' do
  
    # create conversation 1 and verify
    create_conversation
    expect(@user.conversations.count).to eq(1)
    
    # create a second conversation with the same title and body right away
    visit root_path
    click_link 'Start A Conversation'
    fill_in 'Title', with: @conversation.title
    fill_in 'Message', with: @conversation.body
    click_button 'Start Conversation'
    
    # validate that less than one minute passed
    expect(Time.now).to be < @conversation.created_at + 1.minute
    
    # verify that a new conversation was not created
    @user.conversations.reload
    expect(@user.conversations.count).to eq(1)
    
    # should be redirected to the actual conversation
    expect(page).to have_current_path(conversation_path(@conversation.slug)) 
    
  end
  
  scenario 'user tries to create the same reply twice' do
  
    # create conversation
    create_conversation
    
    # create reply 1 and verify
    create_reply @conversation.id
    expect(@conversation.replies.count).to eq(1)
    
    # create a second reply with the same message right away
    fill_in 'Reply', with: @reply.body
    click_button 'Reply'
    
    # validate that less than one minute passed
    expect(Time.now).to be < @reply.created_at + 1.minute
    
    # verify that a new reply was not created
    expect(@conversation.replies.count).to eq(1)
    
    # should be redirected to the actual conversation
    expect(page).to have_current_path(conversation_path(@conversation.slug)) 
    
  end

end
