require 'rails_helper.rb'

require "shared.rb"

feature 'personal info' do
      
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
  end
  
  scenario 'change password' do
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    
    click_link "Change Password"
    
    @new_password = SecureRandom.hex(5)
    
    fill_in "current_password", with: @PASSWORD
    fill_in "password", with: @new_password
    fill_in "password_confirmation", with: @new_password
    
    click_button "Update Password"
    
    expect(page).not_to have_content("Choose a new password")
    
    expect(page).to have_content("Your Profile")
    

    # reload user
    @user = OurnaropaForum::User.find_by email: @user.email
    
    expect(@user.authenticate(@new_password)).to be true
    
  end
  
  scenario "user goes to profile page" do
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_content("Profile")
  end
  
  scenario "user updates all fields" do
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    
    data = {:first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :hometown => Faker::Address.city +  ", " + Faker::Address.country,
        :major => Faker::Company.name,
        :age => Faker::Number.number(2),
        :description => Faker::Lorem.paragraph(5)}
    
    
    expect(@user.info.hometown).not_to eq(data[:hometown])
    expect(@user.info.major).not_to eq(data[:major])
    expect(@user.info.age).not_to eq(data[:age])
    expect(page).not_to have_content(data[:description])
    
    fill_in 'First name', with: data[:first_name]
    fill_in 'Last name', with: data[:last_name]
    fill_in 'Hometown', with: data[:hometown]
    fill_in 'Major',  with: data[:major]
    fill_in 'Age', with: data[:age]
    fill_in 'About Me', with: data[:description]
    
    click_button "Save"
    
    # reload data
    @user.info.reload
    
    expect(@user.info.hometown).to eq(data[:hometown])
    expect(@user.info.major).to eq(data[:major])
    expect(@user.info.age).to eq(data[:age])
    expect(page).to have_content(data[:description])
    
  end
    
  scenario 'user shares email publicly' do
    
    # visit profile page
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_current_path(profile_path)
    expect(page.find("#user_info_email").value).to eq(@user.email)
    
    # validate that currently user is not sharing email address
    expect(page).to have_unchecked_field("is_sharing_email")
    expect(@user.is_sharing_email).to be false
    
    # check the box and save
    check("is_sharing_email")
    click_button "Save"
    
    # verify that is now shared
    expect(page).to have_checked_field("is_sharing_email")
    expect(@user.is_sharing_email).to be true
    
    # uncheck box and save
    check("is_sharing_email")
    click_button "Save"
    
    # validate that currently user is not sharing email address
    expect(page).to have_unchecked_field("is_sharing_email")
    expect(@user.is_sharing_email).to be false    
    
  end
  
#  scenario "unsubscribe from all notifications" do
#    pending
#  end  
  
end