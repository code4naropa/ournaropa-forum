require 'rails_helper.rb'

require "shared.rb"

feature 'User Notifier' do 
  
  include_context "shared functions"
    
  scenario 'users are notified of new reply' do
    
    create_and_sign_in_user
    create_conversation
    
    
    pending
    
  end
  
  scenario 'users are notified after not checking in for seven days' do
    
    pending
    
  end

end
