RSpec.shared_context "shared functions", :a => :b do
  
  def create_access_for_user
    @p_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
  end
  
  def register_user    
    
    create_access_for_user
    
    user_count = OurnaropaForum::User.count
    
    visit '/forum'
    click_link 'Sign Up'
    
    fill_in 'email', with: @p_user.email
    
    click_button 'verify'
    
    expect(page).to have_content("Awesome, " + @p_user.first_name)
    
    click_button 'yup'
    
    expect(page).to have_content("Ready to go!")
    
    # expect creation of a user
    expect(OurnaropaForum::User.count).to eq(user_count+1)
    
    @user = OurnaropaForum::User.find_by email: @p_user.email
    expect(@user.email).to eq(@p_user.email)
    expect(@user.first_name).to eq(@p_user.first_name)
    expect(@user.last_name).to eq(@p_user.last_name)
    expect(@user.role).to eq(@p_user.role)
    
    # expect creation of user data
    expect(@user.info).to be_present
    
    # expect permitted_user to indicate sign_up
    @p_user = OurnaropaForum::PermittedUser.find_by email: @user.email
    expect(@p_user.has_signed_up).to be true
  end
  
  def register_user_and_create_password
    
    email = ActionMailer::Base.deliveries = []
    
    register_user
    
    # open email
    email = ActionMailer::Base.deliveries.first
    
    expect(email.body).to include(default_url_options[:host] + "/forum/" + @user.id + "/reset-password/" + @user.reset_token)
    
    # navigate to finish signup by setting password
    visit "http://" + default_url_options[:host] + "/forum/" + @user.id + "/reset-password/" + @user.reset_token
    
    @PASSWORD = SecureRandom.hex
    
    fill_in 'password', with: @PASSWORD
    fill_in 'password_confirmation', with: @PASSWORD
    
    click_button 'Save'
    
    @user.reload
    expect(@user.authenticate(@PASSWORD))
  end
  
  def create_and_sign_in_user   
    register_user_and_create_password
    
    visit '/forum'
    click_link 'Log In'
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In', match: :first
    
    expect(page).to have_content("Conversations")
    expect(page).to have_content(@user.name)

    
  end
  
end