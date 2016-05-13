require 'rails_helper'

module OurnaropaForum
  RSpec.describe PasswordsController, type: :controller do

    describe "GET #forgot" do
      it "returns http success" do
        get :forgot
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #reset" do
      it "returns http success" do
        get :reset
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #update" do
      it "returns http success" do
        get :update
        expect(response).to have_http_status(:success)
      end
    end

  end
end
