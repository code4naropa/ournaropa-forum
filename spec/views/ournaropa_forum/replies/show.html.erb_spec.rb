require 'rails_helper'

RSpec.describe "replies/show", type: :view do
  before(:each) do
    @reply = assign(:reply, Reply.create!(
      :title => "Title",
      :body => "MyText",
      :author_id => 1,
      :conversation => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
