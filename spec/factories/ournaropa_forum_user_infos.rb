FactoryGirl.define do
  factory :ournaropa_forum_user_info, class: 'OurnaropaForum::UserInfo' do
    hometown "MyString"
    major "MyString"
    age "MyString"
    description "MyText"
    show_email false
  end
end
