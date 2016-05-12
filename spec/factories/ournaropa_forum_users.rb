FactoryGirl.define do
  factory :ournaropa_forum_user, class: 'OurnaropaForum::User' do
    email "MyString"
    name "MyString"
    password_hash "MyString"
    reset_token "MyString"
  end
end
