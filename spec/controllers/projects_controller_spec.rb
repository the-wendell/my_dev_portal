require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  login_user
  let(:portfolio) { FactoryGirl.create(:portfolio, user: subject.current_user) }

  let(:valid_attributes) do
    { title: 'testing title',
      descrption: 'exiting stuff',
      role: 'BMOC',
      tech: 'fancey things',
      link: 'a place',
      order: 1 }
  end

  describe 'projects#create' do
    it 'Allows user to create a new project' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      expect(portfolio.projects.all.count).to eq(1)
    end
    it 'Redirects to project view' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'projects_view'))
    end
  end

  describe 'projects#update' do
    it 'Allows use to update project' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: portfolio.projects.first.id,
                               project: { title: 'working' } }
      expect(portfolio.projects.first.title).to eq('working')
    end
    it 'Redirects to project view' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: portfolio.projects.first.id,
                               project: { title: 'working' } }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'projects_view'))
    end
  end

  describe 'projects#destroy' do
    it 'Allows user to delete project' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      delete :destroy, params: { portfolio_id: portfolio.id,
                                 id: portfolio.projects.first.id }
      expect(portfolio.projects.all.count).to eq(0)
    end
    it 'Redirects to project view' do
      post :create, params: { portfolio_id: portfolio.id,
                              project: valid_attributes }
      delete :destroy, params: { portfolio_id: portfolio.id,
                                 id: portfolio.projects.first.id }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'projects_view'))
    end
  end
end
