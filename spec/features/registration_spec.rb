require 'rails_helper.rb'

require "shared.rb"

feature 'registration' do
      
  include_context "shared functions"
    
  scenario "user signs up" do
    register_user
    
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
    
  scenario "user enters email that is not permitted to access" do
    create_access_for_user
    
    pending
  end
  
  scenario "user enters email that has already been signed up" do
    create_access_for_user
    
    pending
  end
    
end