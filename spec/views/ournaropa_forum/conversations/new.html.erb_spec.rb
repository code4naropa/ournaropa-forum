require 'rails_helper'

RSpec.describe "conversations/new", type: :view do
  before(:each) do
    assign(:conversation, Conversation.new(
      :title => "MyString",
      :body => "MyText",
      :author_id => 1
    ))
  end

  it "renders new conversation form" do
    render

    assert_select "form[action=?][method=?]", conversations_path, "post" do

      assert_select "input#conversation_title[name=?]", "conversation[title]"

      assert_select "textarea#conversation_body[name=?]", "conversation[body]"

      assert_select "input#conversation_author_id[name=?]", "conversation[author_id]"
    end
  end
end
