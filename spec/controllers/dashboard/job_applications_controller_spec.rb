require 'rails_helper'

RSpec.describe Dashboard::JobApplicationsController, type: :controller do
  login_user
  let(:portfolio) { FactoryGirl.create(:portfolio, user: subject.current_user) }

  let(:valid_attributes) do
    { first_contact_date: '2017-08-04',
      company_name: 'The First Order',
      job_location: 'Remote',
      enthusiasm: 'high',
      job_title: 'Supreme Leader',
      referral: 'Snoke',
      referral_type: 'mentor',
      status: 'applied',
      industry: 'ruling the galaxy' }
  end

  let(:invalid_attributes) do
    { first_contact_date: '2017-08-04',
      company_name: 'The First Order',
      job_location: 'Remote',
      enthusiasm: 'adfdaf',
      job_title: 'Supreme Leader',
      referral: 'Snoke',
      referral_type: 'adfds',
      status: 'dafdsf',
      industry: 'ruling the galaxy' }
  end

  let(:portfolio_attributes) do
    { url: 'testing',
      color_one: '#ffffff',
      color_two: '#ffffff',
      color_three: '#ffffff',
      color_four: '#ffffff',
      font_color_one: '#ffffff',
      font_color_two: '#ffffff',
      theme: 'default',
      id: 1 }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobApplicationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET" do
    before(:each) do
      subject.current_user.portfolios.create! portfolio_attributes
      @job_application = subject.current_user.job_applications.create! valid_attributes
    end

    it "#index returns a success response" do
      get :index, params: { user_id: subject.current_user.id }, session: valid_session
      expect(response).to be_success
    end

    it "#show returns a success response" do
      get :show, params: { user_id: subject.current_user.id, id: @job_application.id }, session: valid_session
      expect(response).to be_success
    end

    it "#new returns a success response" do
      get :new, params: { user_id: subject.current_user.id }, session: valid_session
      expect(response).to be_success
    end

    it "#edit returns a success response" do
      get :edit, params: { user_id: subject.current_user.id, id: @job_application.id }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    before(:each) do
      subject.current_user.portfolios.create! portfolio_attributes
    end

    context "with valid params" do
      it "creates a new JobApplication" do
        expect {
          post :create, params: {job_application: valid_attributes, user_id: subject.current_user.id }, session: valid_session
        }.to change(JobApplication, :count).by(1)
      end

      it "redirects to the created job_application" do
        post :create, params: {job_application: valid_attributes, user_id: subject.current_user.id }, session: valid_session
        expect(response).to redirect_to(user_job_applications_path(subject.current_user))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {job_application: invalid_attributes, user_id: subject.current_user.id }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      subject.current_user.portfolios.create! portfolio_attributes
      @job_application = subject.current_user.job_applications.create! valid_attributes
    end

    context "with valid params" do
      let(:new_attributes) { { company_name: 'Rebal Alliance' } }

      it "updates the requested job_application" do
        put :update, params: { id: @job_application.to_param,
                               job_application: new_attributes,
                               user_id: subject.current_user.id }, session: valid_session
        @job_application.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the job_application" do
        put :update, params: { id: @job_application.to_param,
                               job_application: valid_attributes,
                               user_id: subject.current_user.id }, session: valid_session
        expect(response).to redirect_to(user_job_applications_path(subject.current_user))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: @job_application.to_param,
                               job_application: invalid_attributes,
                               user_id: subject.current_user.id }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      subject.current_user.portfolios.create! portfolio_attributes
      @job_application = subject.current_user.job_applications.create! valid_attributes
    end

    it "destroys the requested job_application" do
      expect {
        delete :destroy, params: { id: @job_application.to_param,
                                   user_id: subject.current_user.id }, session: valid_session
      }.to change(JobApplication, :count).by(-1)
    end

    it "redirects to the job_applications list" do
      delete :destroy, params: { id: @job_application.to_param,
                                 user_id: subject.current_user.id }, session: valid_session
      expect(response).to redirect_to(user_job_applications_path(subject.current_user))
    end
  end

end
