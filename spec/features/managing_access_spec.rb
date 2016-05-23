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
    
    visit root_path
    
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
    
    visit root_path
    
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
    
    # make user superuser so that they have access
    @user.is_superuser = true
    @user.save
    expect(@user.is_superuser).to be true
    
    # navigate to new user form
    visit root_path
    click_link "Manage Access", match: :first
    click_link "New User"
    
    # fill out form
    attributes = FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    fill_in "Email", with: attributes[:email]
    fill_in "First name", with: attributes[:first_name]
    fill_in "Last name", with: attributes[:last_name]
    select attributes[:role], from: 'Role'
    click_button "Submit"
    
    # validate new user
    new_user = OurnaropaForum::PermittedUser.find_by email: attributes[:email]
    expect(new_user).to be_present
    expect(new_user.first_name).to eq(attributes[:first_name])
    expect(new_user.last_name).to eq(attributes[:last_name])
    expect(new_user.role).to eq(attributes[:role])
    expect(new_user.is_superuser).to be false
    expect(new_user.has_signed_up).to be false
    
    # validate page
    expect(page).to have_content(attributes[:email])
    
  end

  scenario "superuser revokes access" do
    
    # make user superuser so that they have access
    @user.is_superuser = true
    @user.save
    expect(@user.is_superuser).to be true
    
    # navigate to new user form
    visit root_path
    click_link "Manage Access", match: :first
    click_link "New User"
    
    # fill out form
    attributes = FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    fill_in "Email", with: attributes[:email]
    fill_in "First name", with: attributes[:first_name]
    fill_in "Last name", with: attributes[:last_name]
    select attributes[:role], from: 'Role'
    click_button "Submit"
      
    # validate new user
    new_user = OurnaropaForum::PermittedUser.find_by email: attributes[:email]
    expect(new_user).to be_present
    expect(new_user.email).to eq(attributes[:email])
    expect(new_user.first_name).to eq(attributes[:first_name])
    expect(new_user.last_name).to eq(attributes[:last_name])
    expect(new_user.role).to eq(attributes[:role])
    expect(new_user.is_superuser).to be false
    expect(new_user.has_signed_up).to be false
    
    # validate page
    expect(page).to have_content(attributes[:email])
    
    # navigate to access directory
    visit root_path
    click_link "Manage Access", match: :first

    # destroy user
    page.all("tr").each do |table_row|
      table_row.click_link("Delete") if table_row.has_content?(new_user.email)
    end
    
    # validate deletion of user
    new_user = OurnaropaForum::PermittedUser.find_by email: attributes[:email]
    expect(new_user).to be_nil
    
    # validate page
    expect(page).not_to have_content(attributes[:email])
    
  end

  scenario "superuser attempts to delete user who has already signed up" do

    # make user superuser so that they have access
    @user.is_superuser = true
    @user.save
    expect(@user.is_superuser).to be true
    
    # navigate to new user form
    visit root_path
    click_link "Manage Access", match: :first
    click_link "New User"
    
    # fill out form
    attributes = FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    fill_in "Email", with: attributes[:email]
    fill_in "First name", with: attributes[:first_name]
    fill_in "Last name", with: attributes[:last_name]
    select attributes[:role], from: 'Role'
    click_button "Submit"
    
    # validate new user
    new_user = OurnaropaForum::PermittedUser.find_by email: attributes[:email]
    expect(new_user).to be_present
    expect(new_user.first_name).to eq(attributes[:first_name])
    expect(new_user.last_name).to eq(attributes[:last_name])
    expect(new_user.role).to eq(attributes[:role])
    expect(new_user.is_superuser).to be false
    expect(new_user.has_signed_up).to be false
    
    # validate page
    expect(page).to have_content(attributes[:email])
    
    # sign new user up
    new_user.update_attributes(:has_signed_up => true)
    expect(new_user.has_signed_up).to be true
    
    # trigger delete
    expect(page.all("tr").last).to have_content(new_user.email)
    page.all("tr").last.click_link("Delete")
    
    # validate that user still exists
    new_user = OurnaropaForum::PermittedUser.find_by email: attributes[:email]
    expect(new_user).to be_present
    
    # validate page
    expect(page).to have_content(attributes[:email])
    expect(page.body).to include("Failed: User has already signed up.")
    
  end
  
end