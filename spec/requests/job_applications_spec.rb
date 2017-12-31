require 'rails_helper'

RSpec.describe "JobApplications", type: :request do
  describe "GET /job_applications" do
    it "works! (now write some real specs)" do
      get job_applications_path
      expect(response).to have_http_status(200)
    end
  end
end
