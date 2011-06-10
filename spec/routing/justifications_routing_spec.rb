require "spec_helper"

describe JustificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/justifications").should route_to("justifications#index")
    end

    it "routes to #new" do
      get("/justifications/new").should route_to("justifications#new")
    end

    it "routes to #show" do
      get("/justifications/1").should route_to("justifications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/justifications/1/edit").should route_to("justifications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/justifications").should route_to("justifications#create")
    end

    it "routes to #update" do
      put("/justifications/1").should route_to("justifications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/justifications/1").should route_to("justifications#destroy", :id => "1")
    end

  end
end
