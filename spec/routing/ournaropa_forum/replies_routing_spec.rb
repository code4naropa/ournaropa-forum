require "rails_helper"

module OurnaropaForum
  RSpec.describe RepliesController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/replies").to route_to("replies#index")
      end

      it "routes to #new" do
        expect(:get => "/replies/new").to route_to("replies#new")
      end

      it "routes to #show" do
        expect(:get => "/replies/1").to route_to("replies#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/replies/1/edit").to route_to("replies#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/replies").to route_to("replies#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/replies/1").to route_to("replies#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/replies/1").to route_to("replies#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/replies/1").to route_to("replies#destroy", :id => "1")
      end

    end
  end
end
