require 'rails_helper'

RSpec.describe "permitted_users/index", type: :view do
  before(:each) do
    assign(:permitted_users, [
      PermittedUser.create!(
        :email => "Email",
        :name => "Name",
        :type => "Type"
      ),
      PermittedUser.create!(
        :email => "Email",
        :name => "Name",
        :type => "Type"
      )
    ])
  end

  it "renders a list of permitted_users" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
