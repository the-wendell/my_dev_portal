require 'rails_helper'

RSpec.describe Dashboard::PortfoliosController, type: :controller do
  login_user
  let(:attributes) do
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
  let(:attributes2) do
    { url: 'test',
      color_one: '#ffffff',
      color_two: '#ffffff',
      color_three: '#ffffff',
      color_four: '#ffffff',
      font_color_one: '#ffffff',
      font_color_two: '#ffffff',
      theme: 'default',
      id: 1 }
  end

  describe 'portfolio#create' do
    it 'Lets new user create a portfolio' do
      subject.current_user.portfolios.create(attributes2)
      post :create, params: {user_id: subject.current_user.id, portfolio: attributes }
      expect(subject.current_user.portfolios[0].url).to eq('testing')
    end
    it 'Redirects to dashboard#index' do
      subject.current_user.portfolios.create(attributes2)
      post :create, params: {user_id: subject.current_user.id, portfolio: attributes }
      expect(response).to redirect_to(user_dashboard_index_path(subject.current_user))
    end
  end

  describe 'portfolio#update' do
    let(:portfolio) { subject.current_user.portfolios.create(attributes) }
    it 'Lets user edit portfolio URL' do
      patch :update, params: { user_id: subject.current_user.id,
                               id: portfolio.id,
                               portfolio: { url: 'test' },
                               user: subject.current_user }
      expect(subject.current_user.portfolios.first.url).to eq('test')
    end
    it 'on success it reloads the same page' do
      patch :update, params: { user_id: subject.current_user.id,
                               id: portfolio.id,
                               portfolio: { url: 'test' },
                               user: subject.current_user }
      puts portfolio.errors.full_messages
      expect(response).to redirect_to(edit_user_portfolio_path(subject.current_user, portfolio))
    end
  end
end
