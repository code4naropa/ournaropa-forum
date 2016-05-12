require 'rails_helper'

RSpec.describe "permitted_users/edit", type: :view do
  before(:each) do
    @permitted_user = assign(:permitted_user, PermittedUser.create!(
      :email => "MyString",
      :name => "MyString",
      :type => ""
    ))
  end

  it "renders the edit permitted_user form" do
    render

    assert_select "form[action=?][method=?]", permitted_user_path(@permitted_user), "post" do

      assert_select "input#permitted_user_email[name=?]", "permitted_user[email]"

      assert_select "input#permitted_user_name[name=?]", "permitted_user[name]"

      assert_select "input#permitted_user_type[name=?]", "permitted_user[type]"
    end
  end
end
