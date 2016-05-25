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
    
    click_button 'Verify'
    
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
    
    # clear all emails
    email = ActionMailer::Base.deliveries = []
    
    register_user
    
    # open email
    email = ActionMailer::Base.deliveries.last
    
    #binding.pry
    expect(email.body).to include(new_password_after_reset_url(@user.id, @user.reset_token))
    
    # navigate to finish signup by setting password
    visit new_password_after_reset_path(@user.id, @user.reset_token)
    
    @PASSWORD = SecureRandom.hex
    
    fill_in 'password', with: @PASSWORD
    fill_in 'password_confirmation', with: @PASSWORD
    
    click_button 'Save'
    
    @user.reload
    expect(@user.authenticate(@PASSWORD)).to be true
  end
  
  def create_and_sign_in_user   
    register_user_and_create_password
    
    visit root_path
    click_link 'Log In'
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In', match: :first
    
    expect(page).to have_content("Conversations")
    expect(page).to have_content(@user.name)

    
  end
  
  # creates a conversation
  def create_conversation
    title = Faker::Lorem.words(3).join(" ")
    body = Faker::Lorem.sentences(3).join(" ")
    
    visit root_path
    click_link 'Start A Conversation'
    fill_in 'Title', with: title
    fill_in 'Message', with: body
    click_button 'Start Conversation'
    
    expect(page).to have_content(title)
    expect(page).to have_content(body)
    expect(page).to have_content("You are currently receiving email notifications about new replies in this conversation.")
    
    @user.conversations.reload
    
    expect(@user.conversations.count).to eq(1)
    
    @conversation = OurnaropaForum::Conversation.first
    expect(@conversation.author).to be_present
  end
  
  # creates a reply
  def create_reply conversation_id
    
    # init
    reply = Faker::Lorem.sentences(3).join(" ")
    reply_count = OurnaropaForum::Conversation.find(conversation_id).replies.count
    
    # create reply
    visit conversation_path(conversation_id)
    fill_in 'Reply', with: reply
    click_button 'Reply'
    
    # validate console
    @reply = OurnaropaForum::Reply.last
    expect(@reply.body).to eq(reply)
    expect(@reply.author).to be_present
    expect(OurnaropaForum::Conversation.find(conversation_id).replies.count).to eq(reply_count+1)
    
    # validate successful creation
    expect(page).to have_content(reply)
    expect(page.body).to include("Reply successfully posted.")
    
  end
  
end