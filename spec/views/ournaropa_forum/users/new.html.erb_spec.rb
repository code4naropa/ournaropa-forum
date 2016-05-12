require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :email => "MyString",
      :name => "MyString",
      :password_hash => "MyString",
      :reset_token => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_password_hash[name=?]", "user[password_hash]"

      assert_select "input#user_reset_token[name=?]", "user[reset_token]"
    end
  end
end
