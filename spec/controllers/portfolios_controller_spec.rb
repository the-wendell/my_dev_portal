require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  login_user

  describe 'Create Portfolio' do
    it 'Lets new user create a portfolio' do
      subject.current_user.portfolios.create(url: 'testing')
      expect(subject.current_user.portfolios.first.url).to eq('testing')
    end
    it 'URLs are unique' do
      subject.current_user.portfolios.create(url: 'testing')
      portfolio = subject.current_user.portfolios.create(url: 'testing')
      expect(portfolio.errors.full_messages.first).to eq('Url has already been taken')
    end
    it 'URLs are atleast 3 letters long' do
      portfolio = subject.current_user.portfolios.create(url: 't')
      expect(portfolio.errors.full_messages.first).to eq('Url is too short (minimum is 3 characters)')
    end
    it 'URL is not blank' do
      portfolio = subject.current_user.portfolios.create(url: '   ')
      expect(portfolio.errors.full_messages.first).to eq("Url can't be blank")
    end
  end

  describe 'Update Portfolio' do
    let(:portfolio) { subject.current_user.portfolios.create(url: 'testing') }
    it 'Lets user edit portfolio URL' do
      portfolio.update(url: 'test')
      expect(subject.current_user.portfolios.first.url).to eq('test')
    end
    it 'URLs are unique' do
      subject.current_user.portfolios.create(url: 'test')
      portfolio.update(url: 'test')
      expect(portfolio.errors.full_messages.first).to eq('Url has already been taken')
    end
    it 'URLs are atleast 3 letters long' do
      portfolio.update(url: 't')
      expect(portfolio.errors.full_messages.first).to eq('Url is too short (minimum is 3 characters)')
    end
    it 'URL is not blank' do
      portfolio.update(url: '     ')
      expect(portfolio.errors.full_messages.first).to eq("Url can't be blank")
    end
  end
end
