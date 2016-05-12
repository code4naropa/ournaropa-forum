require 'rails_helper.rb'

feature 'authentication' do
      
  scenario "user goes to log in screen" do
    visit '/forum'
    click_link 'Log In'
    expect(page).to have_content("Email Address")
    expect(page).to have_content("Password")
  end
  
  scenario "user enters invalid email" do
    pending
  end
  
  scenario "user enters invalid password" do
    visit '/forum'
    pending
  end
  
  scenario "user enters valid email and password" do
    visit '/forum'
    pending
  end
end