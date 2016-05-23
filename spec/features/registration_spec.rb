require 'rails_helper.rb'

require "shared.rb"

feature 'registration' do
      
  include_context "shared functions"
    
  scenario "user signs up" do
    register_user
    
    # expect creation of a user
    expect(OurnaropaForum::User.count).to eq(1)
    
    @user = OurnaropaForum::User.first
    expect(@user.email).to eq(@p_user.email)
    expect(@user.first_name).to eq(@p_user.first_name)
    expect(@user.last_name).to eq(@p_user.last_name)
    expect(@user.role).to eq(@p_user.role)
    
    # expect creation of user data
    expect(@user.info).to be_present
    
    # expect permitted_user to indicate sign_up
    @p_user = OurnaropaForum::PermittedUser.first
    expect(@p_user.has_signed_up).to be true
  end
    
  scenario "user enters email that is not permitted to access" do
    
    # generate random email
    random_email = Faker::Internet.email
    
    # validate that no access for this email exists
    expect(OurnaropaForum::PermittedUser.exists?(email: random_email)).to be false
    
    # try to sign up with this email addresss    
    visit signup_path
    fill_in 'Email', with: random_email
    click_button 'Verify'
    
    # validate result
    expect(page).to have_content("Email not found!")
    
  end
  
  scenario "user enters email that has already been signed up" do
    
    # register a new user
    register_user
    
    # validate that user is registered
    @p_user.reload
    expect(@p_user.has_signed_up).to be true
    
    # try to re-register user
    visit signup_path
    fill_in 'Email', with: @p_user.email
    click_button 'Verify'    
    
    # validate error
    expect(page).to have_content("Already signed up!")
    
  end
    
end