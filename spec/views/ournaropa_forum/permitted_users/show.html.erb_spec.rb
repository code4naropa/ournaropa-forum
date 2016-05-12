require 'rails_helper'

RSpec.describe "permitted_users/show", type: :view do
  before(:each) do
    @permitted_user = assign(:permitted_user, PermittedUser.create!(
      :email => "Email",
      :name => "Name",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
  end
end
