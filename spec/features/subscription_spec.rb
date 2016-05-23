require 'rails_helper.rb'

require "shared.rb"

feature 'Subscriptions' do 
  
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
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
    
    # create conversation
    create_conversation

    # log first user out
    @first_user = @user
    visit logout_path
    
    
    # create a new user
    create_and_sign_in_user
    
    # validate that user is currently unsubscribed to conversation
    visit root_path
    click_link @conversation.title
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
      
    # create a reply
    create_reply @conversation.id
    
    # validate that user is now subscribed [back-end]
    @user.replies.reload
    @conversation.replies.reload
    expect(@conversation.replies.count).to eq(1)
    expect(@user.replies.count).to eq(1)
    
    # validate that user is now subscribed [front-end]
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    
    # validate that both users are subscribed
    @second_user = @user
    @first_user.reload
    @second_user.reload
    @conversation.subscriptions.reload
    expect(@conversation.subscriptions.count).to eq(2)
    expect(@conversation.subscriptions.exists?(@first_user.id)).to be true
    expect(@conversation.subscriptions.exists?(@second_user.id)).to be true
    
  end
  
  scenario 'user toggles notifications using switch at the top of a conversation', :js => true do    
    # create conversation
    create_conversation
    
    # validate that user is currently subscribed to conversation
    visit root_path
    click_link @conversation.title
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    expect(@user.subscriptions.exists?(@conversation.id)).to be true  
    
    # unsubscribe manually by clicking the switch
    page.find("#subscribe-switch").click
    
    # validate that user is now unsubscribed
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
    expect(@user.subscriptions.exists?(@conversation.id)).to be false 
        
    # subscribe manually by clicking the switch
    page.find("#subscribe-switch").click
        
    # validate that user is now subscribed
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    expect(@user.subscriptions.exists?(@conversation.id)).to be true  
  end
  
  scenario 'user replies after unsubscribing and having created the conversation or a previous reply' do
    
    # create conversation
    create_conversation

    # log first user out
    @first_user = @user
    visit logout_path
    
    
    # create a new user
    create_and_sign_in_user
    
    # validate that user is currently unsubscribed to conversation
    visit root_path
    click_link @conversation.title
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
      
    # create a reply
    create_reply @conversation.id
        
    # validate that user is now subscribed [front-end]
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    
    # unsubscribe manually by clicking the switch
    uncheck("subscription")
    
    # validate that user is now unsubscribed
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
    @user.subscriptions.reload
    expect(@user.subscriptions.exists?(@conversation.id)).to be false 
    
    # post another reply
    create_reply @conversation.id
    
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")
    
    # validate that first user is and second user is not subscribed [back-end]
    @second_user = @user
    @second_user.reload
    @first_user.reload
    @conversation.reload
    expect(@conversation.subscriptions.exists?(@first_user.id)).to be true
    expect(@conversation.subscriptions.exists?(@second_user.id)).to be false  
    
    # validate that second user is not subscribed [front-end]
    expect(page).to have_content("You are currently not receiving email notifications about new replies in this conversation.")

  end
  
  scenario 'unsubscribe by URL' do
    
    create_conversation
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
    visit '/forum/conversation/'+@conversation.id+'/unsubscribe'
    
    expect(@conversation.subscriptions.exists?(@user.id)).to be false
    
  end
  
  scenario 'subscribe and unsubscribe by URL' do
  
    # create conversation and expect subscription
    create_conversation    
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
    # now unsubscribe by URL /forum/conversation/@id/unsubscribe
    visit '/forum/conversation/'+@conversation.id+'/unsubscribe'
    expect(@conversation.subscriptions.exists?(@user.id)).to be false
    
    # now subscribe again by URL /forum/conversation/@id/subscribe
    visit '/forum/conversation/'+@conversation.id+'/subscribe'
    expect(@conversation.subscriptions.exists?(@user.id)).to be true
    
  end

end
