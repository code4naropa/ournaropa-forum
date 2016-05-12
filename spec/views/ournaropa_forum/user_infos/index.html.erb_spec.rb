require 'rails_helper'

RSpec.describe "user_infos/index", type: :view do
  before(:each) do
    assign(:user_infos, [
      UserInfo.create!(
        :hometown => "Hometown",
        :major => "Major",
        :age => "Age",
        :description => "MyText",
        :show_email => false
      ),
      UserInfo.create!(
        :hometown => "Hometown",
        :major => "Major",
        :age => "Age",
        :description => "MyText",
        :show_email => false
      )
    ])
  end

  it "renders a list of user_infos" do
    render
    assert_select "tr>td", :text => "Hometown".to_s, :count => 2
    assert_select "tr>td", :text => "Major".to_s, :count => 2
    assert_select "tr>td", :text => "Age".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
