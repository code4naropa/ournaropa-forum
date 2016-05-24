require 'rails_helper.rb'

require "shared.rb"

feature 'User Notifier' do 

  include OurnaropaForum::ApplicationHelper
  include_context "shared functions"
    
  scenario 'users are notified of new reply' do
    
    # create conversation
    create_and_sign_in_user
    @first_user = @user
    create_conversation

    # validate that user is subscribed
    expect(@first_user.subscriptions.exists?(@conversation.id)).to be true  
    
    # log first user out
    visit logout_path
    
    # create a new user
    create_and_sign_in_user
    @second_user = @user
    
    # clear all emails
    ActionMailer::Base.deliveries = []
    
    # have new user reply and log them out
    create_reply @conversation.id
    visit logout_path
    
    # expect exactly one email to have been sent
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.last
    
    # expect @first_user to receive that email
    expect(email.to.first).to eq(@first_user.email)
    expect(email.subject).to eq("[OurNaropa] New Reply in #{@conversation.title}")
    expect(email.body).to include(parse_text @reply.body)
    
    # create a new user
    create_and_sign_in_user
    @third_user = @user
    
    # clear all emails
    ActionMailer::Base.deliveries = []
    
    # have new user reply and log them out
    create_reply @conversation.id
    visit logout_path    
    
    # expect exactly two emails to have been sent
    expect(ActionMailer::Base.deliveries.count).to eq(2)
    
    # expect @first_user to receive the first email
    email = ActionMailer::Base.deliveries.first
    expect(email.to.first).to eq(@first_user.email)
    expect(email.subject).to eq("[OurNaropa] New Reply in #{@conversation.title}")
    expect(email.body).to include(parse_text @reply.body)
    
    # expect @second_user to receive the second email
    email = ActionMailer::Base.deliveries.last
    expect(email.to.first).to eq(@second_user.email)
    expect(email.subject).to eq("[OurNaropa] New Reply in #{@conversation.title}")
    expect(email.body).to include(parse_text @reply.body)    
    
  end
  
  scenario 'users are notified after not checking in for seven days' do
    
    pending
    
  end

end
