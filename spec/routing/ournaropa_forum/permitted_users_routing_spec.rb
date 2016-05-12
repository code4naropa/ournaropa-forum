require "rails_helper"

module OurnaropaForum
  RSpec.describe PermittedUsersController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/permitted_users").to route_to("permitted_users#index")
      end

      it "routes to #new" do
        expect(:get => "/permitted_users/new").to route_to("permitted_users#new")
      end

      it "routes to #show" do
        expect(:get => "/permitted_users/1").to route_to("permitted_users#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/permitted_users/1/edit").to route_to("permitted_users#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/permitted_users").to route_to("permitted_users#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/permitted_users/1").to route_to("permitted_users#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/permitted_users/1").to route_to("permitted_users#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/permitted_users/1").to route_to("permitted_users#destroy", :id => "1")
      end

    end
  end
end
