require 'rails_helper.rb'

require "shared.rb"

feature 'Subscriptions' do 
  
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
  end
  
  def create_conversation
    title = 'Test Conversation' 
    body = "Lorem Ipsum Dolorem\n" * 10
    
    visit '/forum'
    click_link 'Start A Conversation'
    fill_in 'Title', with: title
    fill_in 'Message', with: body
    click_button 'start conversation'
    
    expect(page).to have_content(title)
    expect(page).to have_content(body)
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    
    @user.conversations.reload
    
    expect(@user.conversations.count).to eq(1)
    
    @conversation = OurnaropaForum::Conversation.first
    expect(@conversation.author).to be_present
  end
  
  def create_reply conversation
    body = "Lorem Ipsum Dolorem\n" * 10
    
    visit '/forum'
    click_link @conversation.title
    fill_in 'Reply', with: body
    click_button 'reply'
    
    expect(page).to have_content(body)
        
    @reply = OurnaropaForum::Reply.first
    expect(@reply.author).to be_present
  end
  
  scenario 'create subscriptions when user posts' do
    
    create_conversation
    
    @user.reload
    @conversation.reload
    
    expect(@conversation.subscriptions.count).to eq(1)
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    expect(@user.subscriptions.exists?(@conversation.id)).to be true
    
  end
  
  scenario 'create subscription when user replies' do
    
    create_conversation

    @user.reload
    @conversation.reload
    
    expect(@conversation.subscriptions.count).to eq(1)
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    expect(@user.subscriptions.exists?(@conversation.id)).to be true    
    
    @first_user = @user
    
    visit '/forum/logout'
    
    
    # create new user
    create_and_sign_in_user
    
    visit '/forum'
    
    click_link @conversation.title
    
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
      
    create_reply @conversation
    
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
        
    @user.replies.reload
    @conversation.replies.reload
    expect(@conversation.replies.count).to eq(1)
    expect(@user.replies.count).to eq(1)
    
    @second_user = @user
    
    @first_user.reload
    @second_user.reload
    @conversation.subscriptions.reload
    
    expect(@conversation.subscriptions.count).to eq(2)
    expect(@conversation.subscriptions.exists?(@first_user.id)).to be true
    expect(@conversation.subscriptions.exists?(@second_user.id)).to be true
    
  end
  
  scenario 'unsubscribe by URL' do
    
    create_conversation
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
    visit '/forum/conversation/'+@conversation.id+'/unsubscribe'
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be false
    
  end
  
  scenario 'subscribe by URL' do
  
    create_conversation
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
    # now unsubscribe
    
    visit '/forum/conversation/'+@conversation.id+'/unsubscribe'
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be false
    
    # now subscribe again
  
    visit '/forum/conversation/'+@conversation.id+'/subscribe'
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
  end

end
