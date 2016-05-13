require 'rails_helper.rb'

feature 'registration' do
      
  before do
    @p_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    @p_user.email = "fwoelm@students.naropa.edu"
    @p_user.save
  end
  
  scenario "user signs up" do
    visit '/forum'
    click_link 'Sign Up'
    
    fill_in 'email', with: @p_user.email
    
    click_button 'verify'
    
    expect(page).to have_content("Awesome, " + @p_user.first_name)
    
    click_button 'yup'
    
    expect(page).to have_content("Ready to go!")
    
    # expect creation of a user
    expect(OurnaropaForum::User.count).to eq(1)
    
    @user = OurnaropaForum::User.first
    expect(@user.email).to eq(@p_user.email)
    expect(@user.first_name).to eq(@p_user.first_name)
    expect(@user.last_name).to eq(@p_user.last_name)
    expect(@user.role).to eq(@p_user.role)
    
    # expect creation of user data
    expect(@user.info).to be_present
    
    # expect permitted_user to indicate sign_up
    @p_user = OurnaropaForum::PermittedUser.first
    expect(@p_user.has_signed_up).to be true
  end
    
  scenario 'user is already signed up' do
    pending    
  end
    
end