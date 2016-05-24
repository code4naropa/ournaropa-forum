require 'rails_helper.rb'

require "shared.rb"

feature 'Reset Password' do 
  
  include_context "shared functions"
    
  scenario 'reset password after forgetting about it' do
    
    # register new user with password
    register_user_and_create_password
    
    # go to password reset page
    visit root_path
    click_link "Forgot Password"
    
    # enter email address
    fill_in 'Email', with: @user.email
    click_button 'Reset'
    
    # validate success [back-end]
    @user.reload
    expect(@user.reset_token).to be_present    
    
    # validate success [front-end]
    expect(page).to have_content("Password Recovery en route")   
    
    # validate email
    email = ActionMailer::Base.deliveries.last
    expect(email.body).to include(new_password_after_reset_url(@user.id, @user.reset_token))
    
    # navigate to finish signup by setting password
    visit new_password_after_reset_path(@user.id, @user.reset_token)
    
    # enter new password
    new_password = SecureRandom.hex
    fill_in 'password', with: new_password
    fill_in 'password_confirmation', with: new_password
    click_button 'Save'
    
    # validate [front-end]
    expect(page.body).to include("Your password has been successfully updated")      
    
    # validate [back-end]
    @user = OurnaropaForum::User.find_by email: @user.email
    expect(@user.reset_token).to be_nil
    expect(@user.authenticate(@PASSWORD)).to be false
    expect(@user.authenticate(new_password)).to be true
    
  end
  
  scenario 'try to reset password for wrong email' do
    
    # register new user with password
    register_user_and_create_password
        
    # go to password reset page
    visit root_path
    click_link "Forgot Password"
    
    # enter email address
    email = Faker::Internet.email
    expect(email).not_to eq(@user.email)
    fill_in 'Email', with: email
    click_button 'Reset'
    
    # validate error [front-end]
    expect(page.body).to include("We could not find a user with the email address you entered")      
    
    # validate no change [back-end]
    expect(@user.authenticate(@PASSWORD)).to be true
    expect(@user.reset_token).to be_nil 
    
  end
end
