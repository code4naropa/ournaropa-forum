require 'rails_helper'

RSpec.describe "replies/edit", type: :view do
  before(:each) do
    @reply = assign(:reply, Reply.create!(
      :title => "MyString",
      :body => "MyText",
      :author_id => 1,
      :conversation => nil
    ))
  end

  it "renders the edit reply form" do
    render

    assert_select "form[action=?][method=?]", reply_path(@reply), "post" do

      assert_select "input#reply_title[name=?]", "reply[title]"

      assert_select "textarea#reply_body[name=?]", "reply[body]"

      assert_select "input#reply_author_id[name=?]", "reply[author_id]"

      assert_select "input#reply_conversation_id[name=?]", "reply[conversation_id]"
    end
  end
end
