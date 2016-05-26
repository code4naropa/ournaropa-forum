require 'rails_helper.rb'
require "shared.rb"

feature 'managing email notifications' do
      
  include_context "shared functions"  
  
  before do
    create_and_sign_in_user
  end
  
  scenario "user visits email notification management" do
    
    # visit profile page
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_current_path(profile_path)
    
    # visit subscription management
    click_link("Manage Notifications")
    expect(page).to have_current_path(manage_email_notifications_path)
    expect(page).to have_content("Email Notifications")
  end
    
  scenario "user turns off an email notification" do
    
    # user creates a conversation
    create_conversation
    
    # visit profile page
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_current_path(profile_path)
    
    # visit subscription management
    click_link("Manage Notifications")
    expect(page).to have_current_path(manage_email_notifications_path)
    expect(page).to have_content("Email Notifications")
    
    # conversation should be shown
    expect(page).to have_content(@conversation.title)
    
    # delete email notification
    click_link "Disable"
    
    # verify success [front-end]
    expect(page).not_to have_content(@conversation.title)
    
    # verify success [back-end]
    expect(@user.is_subscribed_to?(@conversation)).to be false
    
  end
  
  scenario "user turns off all email notifications" do
    
    # user creates five conversations
    5.times do
      create_conversation
    end
    
    # visit profile page
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_current_path(profile_path)
    
    # visit subscription management
    click_link("Manage Notifications")
    expect(page).to have_current_path(manage_email_notifications_path)
    expect(page).to have_content("Email Notifications")
    
    # conversations should be shown and user should be subscribed
    expect(page.all("tr").count).to eq(5+2)
    expect(@user.subscriptions.count).to eq(5)    
    
    # delete all email notifications
    click_link "Disable all"
    
    # verify success [front-end]
    expect(page).to have_content("You are currently not receiving email notifications about new replies in conversations")
    
    # verify success [back-end]
    expect(@user.subscriptions.count).to eq(0)    
    expect(OurnaropaForum::Conversation.count).to eq(5)
    
  end
  
  scenario "user turns off and on not-checked-in-reminder", :js => true do

    # validate that user is subscribed
    expect(@user.is_receiving_inactivity_email).to be true
    
    # visit profile page
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_current_path(profile_path)
    
    # visit subscription management
    click_link("Manage Notifications")
    expect(page).to have_current_path(manage_email_notifications_path)
    expect(page).to have_content("Email Notifications")
    
    # turn off
    page.find("#subscribe-switch").click
    
    # validate
    expect(page).to have_content("You will not receive an email with the latest conversations after 7 days of inactivity.")
    @user.reload
    expect(@user.is_receiving_inactivity_email).to be false
    
    # turn on
    page.find("#subscribe-switch").click
    
    # validate
    expect(page).to have_content("You will receive an email with the latest conversations after 7 days of inactivity.")
    @user.reload
    expect(@user.is_receiving_inactivity_email).to be true    
    
  end
  
end