require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :email => "Email",
      :name => "Name",
      :password_hash => "Password Hash",
      :reset_token => "Reset Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Password Hash/)
    expect(rendered).to match(/Reset Token/)
  end
end
