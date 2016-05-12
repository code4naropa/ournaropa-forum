require 'rails_helper'

RSpec.describe "user_infos/new", type: :view do
  before(:each) do
    assign(:user_info, UserInfo.new(
      :hometown => "MyString",
      :major => "MyString",
      :age => "MyString",
      :description => "MyText",
      :show_email => false
    ))
  end

  it "renders new user_info form" do
    render

    assert_select "form[action=?][method=?]", user_infos_path, "post" do

      assert_select "input#user_info_hometown[name=?]", "user_info[hometown]"

      assert_select "input#user_info_major[name=?]", "user_info[major]"

      assert_select "input#user_info_age[name=?]", "user_info[age]"

      assert_select "textarea#user_info_description[name=?]", "user_info[description]"

      assert_select "input#user_info_show_email[name=?]", "user_info[show_email]"
    end
  end
end
