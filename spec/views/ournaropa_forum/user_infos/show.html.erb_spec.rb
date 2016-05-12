require 'rails_helper'

RSpec.describe "user_infos/show", type: :view do
  before(:each) do
    @user_info = assign(:user_info, UserInfo.create!(
      :hometown => "Hometown",
      :major => "Major",
      :age => "Age",
      :description => "MyText",
      :show_email => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hometown/)
    expect(rendered).to match(/Major/)
    expect(rendered).to match(/Age/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
