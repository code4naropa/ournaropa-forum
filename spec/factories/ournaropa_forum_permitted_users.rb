FactoryGirl.define do
  factory :ournaropa_forum_permitted_user, class: 'OurnaropaForum::PermittedUser' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { "Incoming Student" }
  end
end
