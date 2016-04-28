FactoryGirl.define do
  factory :ournaropa_forum_reply, class: 'OurnaropaForum::Reply' do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph(30) }
    author_id { Faker::Number.between(0, 500)}
    #conversation nil
  end
end
