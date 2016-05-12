require 'rails_helper'

module OurnaropaForum
  RSpec.describe RegistrationsController, type: :controller do

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #verify" do
      it "returns http success" do
        get :verify
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #create" do
      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

  end
end
