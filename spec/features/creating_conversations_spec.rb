require 'spec_helper.rb'

feature 'Creating conversations' do  
  scenario 'can create a job' do
    
    title = 'Test Conversation' 
    body = "Lorem Ipsum Dolorem\n" * 10
    
    visit '/forum'
    click_link 'New Conversation'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    fill_in 'Author', with: 1
    click_button 'Create Conversation'
    expect(page).to have_content(title)
    expect(page).to have_content(body)
  end
end  