require 'rails_helper.rb'

require "shared.rb"

feature 'managing access' do
      
  include_context "shared functions"  
  
  before do
    create_and_sign_in_user
  end
  
  scenario "user is superuser" do
    
    @user.is_superuser = true
    @user.save
    expect(@user.is_superuser).to be true
    
    visit '/forum'
    
    expect(page).not_to have_content("Email")
    expect(page).not_to have_content("First Name")
    expect(page).not_to have_content("Last Name")
    expect(page).not_to have_content("Role")
    
    
    click_link "Manage Access", match: :first
    
    expect(page).to have_content("Email")
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Role")
  end
    
  scenario "user is not superuser" do
    
    @user.is_superuser = false
    @user.save
    expect(@user.is_superuser).to be false
    
    visit '/forum'
    
    expect(page).not_to have_content("Manage Access")
    expect(page).not_to have_content("Email")
    expect(page).not_to have_content("First Name")
    expect(page).not_to have_content("Last Name")
    expect(page).not_to have_content("Role")
    
    visit '/forum/manage-access'
    
    expect(page).not_to have_content("Manage Access")
    expect(page).not_to have_content("Email")
    expect(page).not_to have_content("First Name")
    expect(page).not_to have_content("Last Name")
    expect(page).not_to have_content("Role")
  end
  
  scenario "superuser grants access" do
    pending
  end

  scenario "superuser revokes access" do
    pending
  end

  scenario "superuser attempts to delete user who has already signed up" do
    pending
  end
  
end