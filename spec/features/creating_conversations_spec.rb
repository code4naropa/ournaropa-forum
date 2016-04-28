require 'rails_helper.rb'

feature 'Creating conversations' do  
  scenario 'can create a conversation' do
    
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

feature 'Creating replies' do  
  scenario 'can create a reply' do
    
    @conversation = OurnaropaForum::Conversation.create! FactoryGirl.attributes_for(:ournaropa_forum_conversation)
    
    title = 'Test Conversation' 
    body = "Lorem Ipsum Dolorem\n" * 10
    
    visit '/forum'
    click_link @conversation.title
    click_link 'New Reply'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    fill_in 'Author', with: 1
    click_button 'Create Reply'
    expect(page).to have_content(title)
    expect(page).to have_content(body)
  end
    
end  

feature 'Editing Settings' do  
  scenario 'can see settings' do
      
    visit '/forum'
    click_link "Settings"
    expect(page).to have_content("Name")
    expect(page).to have_content("Bio")
  end
  
  scenario 'can update settings' do
      
    new_bio = "blablabla"*3
    
    visit '/forum'
    click_link "Settings"
    expect(page).not_to have_content(new_bio)
    click_link "Edit"
    fill_in 'Bio', with: 'new_bio_blablabla'
    expect(page).to have_content("Name")
    expect(page).to have_content("Bio")
    expect(page).to have_content(new_bio)
  end
    
end

feature 'View Profile' do  
  scenario 'can view profile' do
      
    @conversation = OurnaropaForum::Conversation.create! FactoryGirl.attributes_for(:ournaropa_forum_conversation)
    
    visit '/forum'
    click_link @conversation.title
    click_link "Author"
    
    expect(page).to have_content("Name")
    expect(page).to have_content("Bio")
  end
    
end