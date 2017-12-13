require 'rails_helper'

RSpec.describe TechnologiesController, type: :controller do
  login_user
  let(:portfolio) { FactoryGirl.create(:portfolio, user: subject.current_user) }
  let(:valid_attributes) do
    { name: 'Ruby',
      years_exp: 1,
      proficiency: 8,
      show_years_exp: true,
      show_proficiency: true }
  end

  describe 'technologies#create' do
    it 'Allows user to create a new technology' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      expect(portfolio.technologies.all.count).to eq(1)
    end
    it 'Redirects to technologies view' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'technologies'))
    end
  end

  describe 'technologies#update' do
    it 'Allows use to update project' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: portfolio.technologies.first.id,
                               technology: { name: 'Ruby on Rails' } }
      expect(portfolio.technologies.first.name).to eq('Ruby on Rails')
    end
    it 'Redirects to technologies view' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: portfolio.technologies.first.id,
                               technology: { name: 'Ruby on Rails' } }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'technologies'))
    end
  end

  describe 'technologies#destroy' do
    it 'Allows user to delete project' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      delete :destroy, params: { portfolio_id: portfolio.id,
                                 id: portfolio.technologies.first.id }
      expect(portfolio.technologies.all.count).to eq(0)
    end
    it 'Redirects to technologies view' do
      post :create, params: { portfolio_id: portfolio.id,
                              technology: valid_attributes }
      delete :destroy, params: { portfolio_id: portfolio.id,
                                 id: portfolio.technologies.first.id }
      expect(response).to redirect_to(dashboard_index_path(menu_action: 'technologies'))
    end
  end

end
