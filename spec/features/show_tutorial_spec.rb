require 'rails_helper.rb'
require "shared.rb"

feature 'tutorial' do
      
  include_context "shared functions"
  
  before do
    register_user_and_create_password
  end
  
  scenario 'user logs in for first time -> is shown tutorial', :js => true do
    
    # validate that user has not yet finished tutorial
    expect(@user.has_finished_tutorial).to be false
    
    # Log In
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In', match: :first
    
    # validate that user is shown tutorial
    expect(page).to have_content("tutorial")
    click_button "Next"
    expect(page).to have_content("Step 1")
    click_button "Next"
    expect(page).to have_content("Step 2")
    click_button "Next"
    expect(page).to have_content("Step 3")
    click_button "Next"
    expect(page).to have_content("Step 4")
    click_button "Done"
    
    # validate that user has finished tutorial
    expect(@user.has_finished_tutorial).to be true
    
  end
 
  scenario "user logs in for second time after interrupting tutorial -> is shown tutorial again", :js => true  do

    # validate that user has not yet finished tutorial
    expect(@user.has_finished_tutorial).to be false
    
    # Log In
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In', match: :first
    
    # Show Tutorial
    expect(page).to have_content("tutorial")
    click_button "Next"
    expect(page).to have_content("Step 1")
    click_button "Next"
    
    # Interrupt Tutorial
    visit logout_path
    
    # Log In
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In', match: :first
    
    # validate that user sees tutorial agian
    expect(page).to have_content("tutorial")
    
  end  
  
  scenario "user logs in for second time after completing tutorial -> is not shown tutorial", :js => true  do
    
    # Log In
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In', match: :first
    
    # finish tutorial
    expect(page).to have_content("tutorial")
    click_button "Next"
    expect(page).to have_content("Step 1")
    click_button "Next"
    expect(page).to have_content("Step 2")
    click_button "Next"
    expect(page).to have_content("Step 3")
    click_button "Next"
    expect(page).to have_content("Step 4")
    click_button "Done"
    
    # validate that user has finished tutorial
    expect(@user.has_finished_tutorial).to be true    
    
    # log user out
    visit logout_path
    
    # Log In again
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In', match: :first    
    
    # validate that tutorial is not being shown again
    expect(page).not_to have_content("tutorial")
    
  end
  
end