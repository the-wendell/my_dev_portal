require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  describe 'Create Portfolio' do
    it 'creates a new portfolio' do
      user.portfolios.create(url: 'testing')
      expect(Portfolio.first.url).to eq('testing')
    end
    it 'requires a user' do
      Portfolio.create(url: 'testing')
      expect(Portfolio.all.count).to eq(0)
    end
    it 'URLs are unique' do
      user.portfolios.create(url: 'testing')
      portfolio = user2.portfolios.create(url: 'testing')
      expect(portfolio.errors.full_messages.first).to eq('Url has already been taken')
    end
    it 'URLs are atleast 3 letters long' do
      portfolio = user.portfolios.create(url: 't')
      expect(portfolio.errors.full_messages.first).to eq('Url is too short (minimum is 3 characters)')
    end
    it 'URL is not blank' do
      portfolio = user.portfolios.create(url: '      ')
      expect(portfolio.errors.full_messages.first).to eq("Url can't be blank")
    end
  end

  describe 'Update Portfolio' do
    let(:portfolio) { user.portfolios.create(url: 'testing') }
    it 'edits portfolio URL' do
      portfolio.update(url: 'test')
      expect(user.portfolios.first.url).to eq('test')
    end
    it 'URLs are unique' do
      user.portfolios.create(url: 'test')
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
