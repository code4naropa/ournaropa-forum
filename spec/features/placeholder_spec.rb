#require 'rails_helper.rb'
#
###################
### ACCOUNTS
###################
#feature 'accounts' do
#  
#  scenario 'cannot create an unpermitted account' do
#    
#    email_to_test = "abc@abc.com"
#    
#    # make sure email is not permtited
#    expect(OurnaropaForum::PermittedUser.find_by_email(email_to_test)).to be_nil
#    
#    visit '/forum'
#    click_link 'Sign Up'
#    fill_in 'Email', with: email_to_test
#    click_button "Ok"
#      
#    expect(page).to have_content("Sorry, email does not exist. Please contact the Admissions Office if you believe this is a mistake.")
#      
#  end
#  
#  scenario 'can create an account' do
#
#    @permitted_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
#    
#    # make sure email is not permtited
#    expect(OurnaropaForum::PermittedUsers.find_by_email(@permitted_user.email)).to be_present
#    expect(OurnaropaForum::User.count).to eq(0)
#    
#    visit '/forum'
#    click_link 'Sign Up'
#    fill_in 'Email', with: @permitted_user.email
#    click_button "Ok"
#    
#    expect(page).to have_content("Hi")
#    expect(page).to have_content(@permitted_user.name)
#      
#      
#    click_button "Yup, that's me"
#      
#    # create new account
#    expect(OurnaropaForum::User.count).to eq(1)
#    
#  end
#    
#  scenario "can log in" do
#    pending
#  end
#  
#  scenario "can reset password" do
#    pending
#  end
#end
#
###################
### SUBSCRIPTIONS
###################
#feature 'Subscriptions:' do
#  scenario 'subscribe to topic' do
#    pending
#  end
#  
#  scenario 'unsubscribe from topic' do
#    pending
#  end
#  
#  scenario 'unsubscribe from all' do
#    pending
#  end
#  
#  scenario 'new replies IF SUBSCRIBED' do
#    pending "expect sending of an email"
#  end
#  
#  scenario 'new replies IF UNSUBSCRIBED' do
#    pending "expect not sending of an email"
#  end
#  
#  scenario 'user not logged in for a week IF SUBSCRIBED' do
#    pending "expect sending of an email"
#  end
#  
#  scenario 'user not logged in for a week IF UNSUBSCRIBED' do
#    pending "expect not sending of an email"
#  end
#end
#  
###################
### TOPICS AND REPLIES
###################
#feature 'Creating conversations' do  
#  scenario 'can create a conversation' do
#    
#    title = 'Test Conversation' 
#    body = "Lorem Ipsum Dolorem\n" * 10
#    
#    visit '/forum'
#    click_link 'New Conversation'
#    fill_in 'Title', with: title
#    fill_in 'Body', with: body
#    fill_in 'Author', with: 1
#    click_button 'Create Conversation'
#    expect(page).to have_content(title)
#    expect(page).to have_content(body)
#  end
#end
#
#feature 'Creating replies' do  
#  scenario 'can create a reply' do
#    
#    @conversation = OurnaropaForum::Conversation.create! FactoryGirl.attributes_for(:ournaropa_forum_conversation)
#    
#    title = 'Test Conversation' 
#    body = "Lorem Ipsum Dolorem\n" * 10
#    
#    visit '/forum'
#    click_link @conversation.title
#    click_link 'New Reply'
#    fill_in 'Title', with: title
#    fill_in 'Body', with: body
#    fill_in 'Author', with: 1
#    click_button 'Create Reply'
#    expect(page).to have_content(title)
#    expect(page).to have_content(body)
#  end
#    
#end  
#
###################
### SETTINGS
###################
#feature 'Editing Settings' do  
#  scenario 'can see settings' do
#      
#    visit '/forum'
#    click_link "Settings"
#    expect(page).to have_content("Name")
#    expect(page).to have_content("Bio")
#  end
#  
#  scenario 'can update settings' do
#      
#    new_bio = "blablabla"*3
#    
#    visit '/forum'
#    click_link "Settings"
#    expect(page).not_to have_content(new_bio)
#    click_link "Edit"
#    fill_in 'Bio', with: 'new_bio_blablabla'
#    expect(page).to have_content("Name")
#    expect(page).to have_content("Bio")
#    expect(page).to have_content(new_bio)
#  end
#    
#end
#
###################
### PROFILES
###################
#feature 'View Profile' do  
#  scenario 'can view profile' do
#      
#    @conversation = OurnaropaForum::Conversation.create! FactoryGirl.attributes_for(:ournaropa_forum_conversation)
#    
#    visit '/forum'
#    click_link @conversation.title
#    click_link "Author"
#    
#    expect(page).to have_content("Name")
#    expect(page).to have_content("Bio")
#  end
#    
#end
#
#
###################
### DIRECTORY
###################
#feature 'View Directory' do  
#  scenario 'can view directory' do
#    
#    10.times do
#      OurnaropaForum::User.create! FactoryGirl.attributes_for(:ournaropa_forum_user)
#    end
#      
#    visit '/forum'
#    click_link "Directory"
#    
#    expect(page).to have_content("Directory")
#    expect(page).to have_content("user-10") # 10 users
#  end
#    
#end