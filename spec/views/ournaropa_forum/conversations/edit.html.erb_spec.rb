require 'rails_helper'

RSpec.describe "conversations/edit", type: :view do
  before(:each) do
    @conversation = assign(:conversation, Conversation.create!(
      :title => "MyString",
      :body => "MyText",
      :author_id => 1
    ))
  end

  it "renders the edit conversation form" do
    render

    assert_select "form[action=?][method=?]", conversation_path(@conversation), "post" do

      assert_select "input#conversation_title[name=?]", "conversation[title]"

      assert_select "textarea#conversation_body[name=?]", "conversation[body]"

      assert_select "input#conversation_author_id[name=?]", "conversation[author_id]"
    end
  end
end
