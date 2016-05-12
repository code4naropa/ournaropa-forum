FactoryGirl.define do
  factory :ournaropa_forum_permitted_user, class: 'OurnaropaForum::PermittedUser' do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    role { "Incoming Student" }
  end
end
