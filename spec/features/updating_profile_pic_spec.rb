require 'rails_helper.rb'

require "shared.rb"

feature 'personal info' do
      
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
    
    visit root_path
    click_link("Hi, " + @user.name + "!", :match => :first)
    
    expect(page).to have_content("Profile")
  end
  
  scenario 'user uploads PNG image' do
    attach_file('user_info_avatar', "spec/files/sample.png")
    click_button 'Save'
    expect(page).to have_css("img[src*='sample.png']")
  end
  
  scenario 'user uploads JPG image' do
    attach_file('user_info_avatar', "spec/files/sample.jpeg")
    click_button 'Save'
    expect(page).to have_css("img[src*='sample.jpeg']")
  end 
  
  scenario 'user uploads animated GIF image' do
    attach_file('user_info_avatar', "spec/files/sample.gif")
    click_button 'Save'
    expect(page).to have_css("img[src*='sample.gif']")
  end
  
  scenario 'user uploads illegal file format' do
    attach_file('user_info_avatar', "spec/files/sample.txt")
    click_button 'Save'
    expect(page).to have_content("Avatar is invalid")
  end
  
  scenario 'user uploads file eceeding max file size' do
    pending
  end
  
  scenario 'user does not change profile picture' do
    pending
  end
  
end