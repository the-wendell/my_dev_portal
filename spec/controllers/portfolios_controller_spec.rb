require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  login_user
  let(:attributes) do
    { url: 'testing',
      color_one: '#ffffff',
      color_two: '#ffffff',
      color_three: '#ffffff',
      color_four: '#ffffff',
      theme: 'default'}
  end
  let(:attributes2) do
    { url: 'portfolio',
      color_one: '#ffffff',
      color_two: '#ffffff',
      color_three: '#ffffff',
      color_four: '#ffffff',
      theme: 'default' }
  end

  describe 'portfolio#create' do
    it 'Lets new user create a portfolio' do
      post :create, params: { portfolio: attributes }
      expect(subject.current_user.portfolios.first.url).to eq('testing')
    end
    it 'Prevents user from creating more than one portfolio' do
      post :create, params: { portfolio: attributes }
      post :create, params: { portfolio: attributes2 }
      expect(subject.current_user.portfolios.all.count).to eq(1)
    end
    it 'Redirects to dashboard#index' do
      post :create, params: { portfolio: attributes }
      expect(response).to redirect_to(dashboard_index_path)
    end
  end

  describe 'portfolio#update' do
    let(:portfolio) { subject.current_user.portfolios.create(attributes) }
    it 'Lets user edit portfolio URL' do
      patch :update, params: { id: portfolio.id, portfolio: { url: 'test' } }
      expect(subject.current_user.portfolios.first.url).to eq('test')
    end
    it 'on success it reloads the same page' do
      patch :update, params: { id: portfolio.id, portfolio: { url: 'test' } }
      expect(response).to redirect_to(edit_portfolio_path(portfolio))
    end
  end

  describe 'portfolio#show' do
    it 'renders the show template' do
      post :create, params: { portfolio: attributes }
      get :show, params: { portfolio: 'testing' }
      expect(response).to render_template('show')
    end
  end
end
