require "rails_helper"

module OurnaropaForum
  RSpec.describe UserInfosController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/user_infos").to route_to("user_infos#index")
      end

      it "routes to #new" do
        expect(:get => "/user_infos/new").to route_to("user_infos#new")
      end

      it "routes to #show" do
        expect(:get => "/user_infos/1").to route_to("user_infos#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/user_infos/1/edit").to route_to("user_infos#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/user_infos").to route_to("user_infos#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/user_infos/1").to route_to("user_infos#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/user_infos/1").to route_to("user_infos#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/user_infos/1").to route_to("user_infos#destroy", :id => "1")
      end

    end
  end
end
