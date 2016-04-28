require 'rails_helper'

RSpec.describe "conversations/index", type: :view do
  before(:each) do
    assign(:conversations, [
      Conversation.create!(
        :title => "Title",
        :body => "MyText",
        :author_id => 1
      ),
      Conversation.create!(
        :title => "Title",
        :body => "MyText",
        :author_id => 1
      )
    ])
  end

  it "renders a list of conversations" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
