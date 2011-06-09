require "spec_helper"

describe NeedsController do
  describe "routing" do

    it "routes to #index" do
      get("/needs").should route_to("needs#index")
    end

    it "routes to #new" do
      get("/needs/new").should route_to("needs#new")
    end

    it "routes to #show" do
      get("/needs/1").should route_to("needs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/needs/1/edit").should route_to("needs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/needs").should route_to("needs#create")
    end

    it "routes to #update" do
      put("/needs/1").should route_to("needs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/needs/1").should route_to("needs#destroy", :id => "1")
    end

  end
end
