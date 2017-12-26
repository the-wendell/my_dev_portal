require 'rails_helper'

RSpec.describe PortfolioHeadersController, type: :controller do
  login_user
  let(:portfolio) { FactoryGirl.create(:portfolio, user: subject.current_user) }

  let(:attributes) do
    { header_one: 'testing title',
      header_two: 'exiting stuff',
      header_two_color: '#ffffff',
      header_one_color: '#ffffff' }
  end

  describe 'portfolio_header#create' do
    it 'Allows user to create a new project' do
      post :create, params: { portfolio_id: portfolio.id,
                              portfolio_header: attributes }
      expect(PortfolioHeader.all.count).to eq(1)
    end
    it 'Redirects to portfolio_header view' do
      post :create, params: { portfolio_id: portfolio.id,
                              portfolio_header: attributes }
      expect(response).to redirect_to(portfolio_portfolio_headers_path(portfolio))
    end
  end

  describe 'portfolio_header#update' do
    it 'Allows use to update project' do
      post :create, params: { portfolio_id: portfolio.id,
                              portfolio_header: attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: PortfolioHeader.first.id,
                               portfolio_header: { header_one: 'working' } }
      expect(PortfolioHeader.first.header_one).to eq('working')
    end
    it 'Redirects to project view' do
      post :create, params: { portfolio_id: portfolio.id,
                              portfolio_header: attributes }
      patch :update, params: { portfolio_id: portfolio.id,
                               id: PortfolioHeader.first.id,
                               portfolio_header: { header_one: 'working' } }
      expect(response).to redirect_to(portfolio_portfolio_headers_path(portfolio))
    end
  end
end
