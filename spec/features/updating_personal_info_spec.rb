require 'rails_helper.rb'

feature 'personal info' do
      
  before do
    @PASSWORD = "ABC"
    @p_user = OurnaropaForum::PermittedUser.create! FactoryGirl.attributes_for(:ournaropa_forum_permitted_user)
    @user = OurnaropaForum::User.new({:first_name => @p_user.first_name, :last_name => @p_user.last_name, :email => @p_user.email})
    @user.password = @PASSWORD
    @user.save
    
    visit '/forum'
    click_link 'Log In'
    
    fill_in 'email', with: @user.email
    fill_in 'password', with: @PASSWORD
    
    click_button 'Log In'    
    
  end
  
  scenario "user goes to profile page" do
    visit '/forum'
    click_link("Hi, " + @user.name + "!", :match => :first)
    expect(page).to have_content("Profile")
  end
  
  scenario "user updates all fields" do
    visit '/forum'
    click_link("Hi, " + @user.name + "!", :match => :first)
    
    data = {:first_name => Faker::Name.first_name,
        :last_name => Faker::Name.last_name,
        :hometown => Faker::Address.city +  ", " + Faker::Address.country,
        :major => Faker::Company.name,
        :age => Faker::Number.number(2),
        :description => Faker::Lorem.paragraph(5)}
    
    
    expect(@user.info.hometown).not_to eq(data[:hometown])
    expect(@user.info.major).not_to eq(data[:major])
    expect(@user.info.age).not_to eq(data[:age])
    expect(page).not_to have_content(data[:description])
    
    fill_in 'First name', with: data[:first_name]
    fill_in 'Last name', with: data[:last_name]
    fill_in 'Hometown', with: data[:hometown]
    fill_in 'Major',  with: data[:major]
    fill_in 'Age', with: data[:age]
    fill_in 'Description', with: data[:description]
    
    click_button "Update"
    
    # reload data
    @user.info.reload
    
    expect(@user.info.hometown).to eq(data[:hometown])
    expect(@user.info.major).to eq(data[:major])
    expect(@user.info.age).to eq(data[:age])
    expect(page).to have_content(data[:description])
    
  end
  
  scenario "user updates profile picture" do
    pending
  end 
  
  scenario "unsubscribe from all notifications" do
    pending
  end  
  
end