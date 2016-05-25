require 'rails_helper.rb'

require "shared.rb"

feature 'authentication' do
      
  include_context "shared functions"  
  
  before do
    register_user_and_create_password
  end
    
  scenario "user goes to log in screen" do
    visit '/forum'
    click_link 'Log In'
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
  end
    
  scenario "user enters invalid email" do
    visit '/forum'
    click_link 'Log In'
    
    wrong_email = Faker::Internet.email
    
    expect(wrong_email).not_to equal(@user.email)
    
    fill_in 'email', with: wrong_email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In', match: :first
    
    expect(page).to have_content("Sign in failed")
    expect(page).to have_content("Login")
    expect(page).not_to have_content(@user.name)
  end
  
  scenario "user enters invalid password" do
    visit '/forum'
    click_link 'Log In'
    
    wrong_password = "adbwerbwer"
    
    expect(wrong_password).not_to equal(@PASSWORD)
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: wrong_password
    
    click_button 'Log In', match: :first
    
    expect(page).to have_content("Sign in failed")
    expect(page).to have_content("Login")
    expect(page).not_to have_content(@user.name)
  end
  
  scenario "user enters valid email and password" do
    visit '/forum'
    click_link 'Log In'
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In', match: :first
    
    expect(page).to have_content("Conversations")
    expect(page).to have_content(@user.name)
  end
  
  scenario "user clicks forgot password" do
    visit '/forum'
    click_link 'Log In'
    
    click_link 'Forgot Password', match: :first
    
    expect(page.current_url).to end_with(forgot_password_path)
    
    expect(page).to have_content("Forgot Your Password?")
  end
  
  #scenario "user wants to visit a specific URL but is prompted to sign in first" do
  #  pending "expect re-direction after successful sign-in"
  #end
end