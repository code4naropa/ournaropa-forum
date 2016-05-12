require 'rails_helper.rb'

feature 'authentication' do
      
  before do
    @PASSWORD = "ABC"
    @p_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    #puts FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    @user = OurnaropaForum::User.new({:name => @p_user.name, :email => @p_user.email})
    @user.password = @PASSWORD
    @user.save
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
    
    click_button 'Log In'
    
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
    
    click_button 'Log In'
    
    expect(page).to have_content("Sign in failed")
    expect(page).to have_content("Login")
    expect(page).not_to have_content(@user.name)
  end
  
  scenario "user enters valid email and password" do
    visit '/forum'
    click_link 'Log In'
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In'
    
    expect(page).to have_content("Conversations")
    expect(page).to have_content(@user.name)
  end
end