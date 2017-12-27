require "rails_helper"

RSpec.describe JobApplicationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/job_applications").to route_to("job_applications#index")
    end

    it "routes to #new" do
      expect(:get => "/job_applications/new").to route_to("job_applications#new")
    end

    it "routes to #show" do
      expect(:get => "/job_applications/1").to route_to("job_applications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/job_applications/1/edit").to route_to("job_applications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/job_applications").to route_to("job_applications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/job_applications/1").to route_to("job_applications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/job_applications/1").to route_to("job_applications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/job_applications/1").to route_to("job_applications#destroy", :id => "1")
    end

  end
end
