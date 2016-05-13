require 'rails_helper'

module OurnaropaForum
  RSpec.describe SubscriptionsController, type: :controller do

    describe "GET #subscribe" do
      it "returns http success" do
        get :subscribe
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #unsubscribe" do
      it "returns http success" do
        get :unsubscribe
        expect(response).to have_http_status(:success)
      end
    end

  end
end
