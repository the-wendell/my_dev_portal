require 'rails_helper'

RSpec.describe Dashboard::JobApplicationsController, type: :controller do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # JobApplication. As you add validations to JobApplication, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobApplicationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      job_application = JobApplication.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      job_application = JobApplication.create! valid_attributes
      get :show, params: {id: job_application.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      job_application = JobApplication.create! valid_attributes
      get :edit, params: {id: job_application.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new JobApplication" do
        expect {
          post :create, params: {job_application: valid_attributes}, session: valid_session
        }.to change(JobApplication, :count).by(1)
      end

      it "redirects to the created job_application" do
        post :create, params: {job_application: valid_attributes}, session: valid_session
        expect(response).to redirect_to(JobApplication.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {job_application: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested job_application" do
        job_application = JobApplication.create! valid_attributes
        put :update, params: {id: job_application.to_param, job_application: new_attributes}, session: valid_session
        job_application.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the job_application" do
        job_application = JobApplication.create! valid_attributes
        put :update, params: {id: job_application.to_param, job_application: valid_attributes}, session: valid_session
        expect(response).to redirect_to(job_application)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        job_application = JobApplication.create! valid_attributes
        put :update, params: {id: job_application.to_param, job_application: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested job_application" do
      job_application = JobApplication.create! valid_attributes
      expect {
        delete :destroy, params: {id: job_application.to_param}, session: valid_session
      }.to change(JobApplication, :count).by(-1)
    end

    it "redirects to the job_applications list" do
      job_application = JobApplication.create! valid_attributes
      delete :destroy, params: {id: job_application.to_param}, session: valid_session
      expect(response).to redirect_to(job_applications_url)
    end
  end

end
