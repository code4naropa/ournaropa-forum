require 'rails_helper.rb'

require "shared.rb"

feature 'Reset Password' do 
  
  include_context "shared functions"
  
  before do
    register_user
  end
  
  def reset_password
    @PASSWORD = SecureRandom.hex(5)
    
    visit '/forum/'+@user.id+'/reset-password/'+@user.reset_token
    
    fill_in 'password', with: @PASSWORD
    fill_in 'password_confirmation', with: @PASSWORD
    
    click_button "Save"
    
    expect(page).to have_content("Login")
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In'
    
    expect(page).to have_content("Conversations")
    expect(page).to have_content(@user.name)
        
    @user.reload
    
    expect(@user.authenticate(@PASSWORD)).to be true    
    expect(@user.reset_token).to be_nil
  end
  
  scenario 'reset password' do
    
    reset_password
    
  end
  
  scenario 'trigger reset' do
    
    reset_password
    
    expect(@user.reset_token).not_to be_present
    
    visit '/forum/logout'
    
    visit '/forum'
    click_link 'forgot password'
    fill_in 'Email', with: @user.email
    click_button 'Reset'

    @user.reload
    
    expect(page).to have_content("Password Recovery en route")
    expect(@user.reset_token).to be_present
  end
end
