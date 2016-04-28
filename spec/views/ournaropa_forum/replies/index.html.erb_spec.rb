require 'rails_helper'

RSpec.describe "replies/index", type: :view do
  before(:each) do
    assign(:replies, [
      Reply.create!(
        :title => "Title",
        :body => "MyText",
        :author_id => 1,
        :conversation => nil
      ),
      Reply.create!(
        :title => "Title",
        :body => "MyText",
        :author_id => 1,
        :conversation => nil
      )
    ])
  end

  it "renders a list of replies" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
