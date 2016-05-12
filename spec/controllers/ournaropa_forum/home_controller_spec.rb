require 'rails_helper'

module OurnaropaForum
  RSpec.describe HomeController, type: :controller do

    describe "GET #welcome" do
      it "returns http success" do
        get :welcome
        expect(response).to have_http_status(:success)
      end
    end

  end
end
