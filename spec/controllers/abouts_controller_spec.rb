require 'rails_helper'

RSpec.describe AboutsController, type: :controller do
  login_user
  let(:portfolio) { FactoryGirl.create(:portfolio, user: subject.current_user) }

  let(:attributes) do
    { about_me: 'testing title',
      about_me_brief: 'exiting stuff',
      location: 'here',
      github: '',
      linkedin: '',
      facebook: '',
      twitter: '',
      website: '' }
  end

  describe 'about#create' do
    it 'Allows user to create a new project' do
      post :create, params: { portfolio_id: portfolio.id,
                              about: attributes }
      record = About.new
      record.portfolio_id = portfolio.id
      record.valid?

      expect(About.all.count).to eq(1)
    end
    it 'Redirects to about view' do
      post :create, params: { portfolio_id: portfolio.id,
                              about: attributes }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'about'))
    end
  end

  describe 'about#update' do
    it 'Allows use to update project' do
      post :create, params: { portfolio_id: portfolio.id,
                              about: attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: About.first.id,
                               about: { about_me: 'working' } }
      expect(About.first.about_me).to eq('working')
    end
    it 'Redirects to project view' do
      post :create, params: { portfolio_id: portfolio.id,
                              about: attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: About.first.id,
                               about: { about_me: 'working' } }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'about'))
    end
  end
end
