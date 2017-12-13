require 'rails_helper'

RSpec.describe Technology, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) { FactoryGirl.create(:portfolio, user: user) }
  let(:attributes) do
    { name: 'Ruby',
      years_exp: 1,
      proficiency: 8,
      show_years_exp: true,
      show_proficiency: true }
  end

  describe '#update' do
    it 'creates new technology' do
      portfolio.technologies.create(attributes)
      expect(portfolio.technologies.all.count).to eq(1)
    end
  end

  describe '#create' do
    it 'updates new technology' do
      record = portfolio.technologies.create(attributes)
      record.update(name: 'updated')
      expect(record.name).to eq('updated')
    end
  end

  describe '#portfolio' do
    it { should belong_to(:portfolio) }
  end

  describe '#proficiency' do
    it { should validate_numericality_of(:proficiency) }
  end

  describe '#years_exp' do
    it { should validate_numericality_of(:years_exp) }
  end

  describe '#name' do
    it { should validate_presence_of(:name) }
    it do
      should validate_length_of(:name)
        .is_at_most(20)
    end
  end
end
