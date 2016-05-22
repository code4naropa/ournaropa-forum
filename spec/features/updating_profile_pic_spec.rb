require 'rails_helper.rb'

require "shared.rb"

feature 'personal info' do
      
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
    
    visit '/forum'
    click_link("Hi, " + @user.name + "!", :match => :first)
    
    expect(page).to have_content("Profile")
  end
  
  scenario 'user uploads PNG image' do
    pending
  end
  
  scenario 'user uploads JPG image' do
    pending
  end 
  
  scenario 'user uploads animated GIF image' do
    pending
  end
  
  scenario 'user uploads illegal file format' do
    pending
  end
  
  scenario 'user uploads file eceeding max file size' do
    pending
  end
  
  scenario 'user does not change profile picture' do
    pending
  end
  
end