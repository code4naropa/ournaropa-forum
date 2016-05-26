require 'rails_helper'

module OurnaropaForum
  RSpec.describe TasksController, type: :controller do

    describe "GET #send_inactivity_emails" do
      it "returns http success" do
        get :send_inactivity_emails
        expect(response).to have_http_status(:success)
      end
    end

  end
end
