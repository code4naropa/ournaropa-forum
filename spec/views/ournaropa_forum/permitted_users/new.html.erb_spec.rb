require 'rails_helper'

RSpec.describe "permitted_users/new", type: :view do
  before(:each) do
    assign(:permitted_user, PermittedUser.new(
      :email => "MyString",
      :name => "MyString",
      :type => ""
    ))
  end

  it "renders new permitted_user form" do
    render

    assert_select "form[action=?][method=?]", permitted_users_path, "post" do

      assert_select "input#permitted_user_email[name=?]", "permitted_user[email]"

      assert_select "input#permitted_user_name[name=?]", "permitted_user[name]"

      assert_select "input#permitted_user_type[name=?]", "permitted_user[type]"
    end
  end
end
