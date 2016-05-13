require 'rails_helper.rb'

feature 'managing access' do
      
  before do
    
    # REGISTER
    @PASSWORD = SecureRandom.uuid
    @p_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    #puts FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    @user = OurnaropaForum::User.new({:first_name => @p_user.first_name, :last_name => @p_user.last_name, :email => @p_user.email})
    @user.password = @PASSWORD
    @user.save
    
    
    # SIGN IN
    visit '/forum'
    click_link 'Log In'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    click_button 'Log In' 
    
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
  
  scenario "add new user" do
    pending
  end

  scenario "delete user" do
    pending
  end

  scenario "cannot delete user that has signed up" do
    pending
  end
  
end