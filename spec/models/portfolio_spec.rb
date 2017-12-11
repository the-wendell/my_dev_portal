require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe 'Create Portfolio' do
    it 'creates a new portfolio' do
      user.portfolios.create(url: 'testing')
      expect(Portfolio.first.url).to eq('testing')
    end
  end

  describe '#user' do
    it { should belong_to(:user) }
  end

  describe '#url' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
    it do
      should validate_length_of(:url)
        .is_at_least(3)
    end
  end

  describe 'Update Portfolio' do
    let(:portfolio) { user.portfolios.create(url: 'testing') }
    it 'edits portfolio URL' do
      portfolio.update(url: 'test')
      expect(user.portfolios.first.url).to eq('test')
    end
  end
end
