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
    
  scenario 'user is notified after not checking in' do
            
    # register user and expect seen_at to be defined
    create_and_sign_in_user
    
    3.times do
      create_conversation
    end
    
    expect(Time.now).to be < @user.seen_at + 1.minute
       
    # clear emails
    ActionMailer::Base.deliveries = []    
    
    30.times do |index|
          
      # update user last seen at: index * days ago
      @user.reload
      @user.update_attributes(:seen_at => Time.now - index * 1.day, :inactivity_email_sent_at => (@user.inactivity_email_sent_at.nil? ? Time.now : @user.inactivity_email_sent_at) - 1.day)
            
      # simulate hitting of API webhook
      visit '/forum/tasks/send-inactivity-emails/'+ENV["WEBHOOK_KEY"]
      
    end

    # expect four emails over the course of thirty days
    expect(ActionMailer::Base.deliveries.count).to eq(4)    
    
  end
  
  scenario 'user is not notified after not checking in if there are no new conversations' do
        
    # register user and expect seen_at to be defined
    register_user
    expect(Time.now).to be < @user.seen_at + 1.minute
       
    # clear emails
    ActionMailer::Base.deliveries = []    
    
    30.times do |index|
      
      # update user last seen at: index * days ago
      @user.reload
      @user.update_attributes(:seen_at => Time.now - index * 1.day, :inactivity_email_sent_at => (@user.inactivity_email_sent_at.nil? ? Time.now : @user.inactivity_email_sent_at) - 1.day)      
      
      # simulate hitting of API webhook
      visit '/forum/tasks/send-inactivity-emails/'+ENV["WEBHOOK_KEY"]
      
    end

    # expect four emails over the course of thirty days
    expect(ActionMailer::Base.deliveries.count).to eq(0)    
    
  end

  scenario 'user is unsubscribed from emails and is not notified after checking in' do
        
    # register user and expect last_seen_at to be defined
    register_user
    expect(Time.now).to be < @user.seen_at + 1.minute
    
    # set user to not receive reminder emails
    @user.update_attributes(:is_receiving_inactivity_email => false)
        
    # clear emails
    ActionMailer::Base.deliveries = []
    
    30.times do |index|
      
      # update user last seen at: index * days ago
      @user.reload
      @user.update_attributes(:seen_at => Time.now - index * 1.day, :inactivity_email_sent_at => (@user.inactivity_email_sent_at.nil? ? Time.now : @user.inactivity_email_sent_at) - 1.day)      
      
      # simulate hitting of API webhook
      visit '/forum/tasks/send-inactivity-emails/'+ENV["WEBHOOK_KEY"]
      
    end

    # expect zero emails over the course of thirty days
    expect(ActionMailer::Base.deliveries.count).to eq(0)    
    
  end  
  
end
