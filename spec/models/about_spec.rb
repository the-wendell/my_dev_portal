require 'rails_helper'

RSpec.describe About, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) { FactoryGirl.create(:portfolio, user: user) }
  let(:attributes) do
    { about_me: 'testing title',
      about_me_brief: 'exiting stuff',
      location: 'here',
      portfolio_id: portfolio.id,
      email: 'myemail',
      github: '',
      linkedin: '',
      facebook: '',
      twitter: '',
      website: '' }
  end

  describe '#create' do
    it 'creates new about' do
      About.create(attributes)
      expect(About.all.count).to eq(1)
    end
  end

  describe '#update' do
    let(:about) { About.create(attributes) }
    it 'updates a about' do
      about.update(about_me: 'updated')
      expect(About.first.about_me).to eq('updated')
    end
  end

  describe '#about_me' do
    it do
      should validate_length_of(:about_me)
        .is_at_most(2000)
    end
  end

  describe '#about_me_brief' do
    it do
      should validate_length_of(:about_me_brief)
        .is_at_most(150)
    end
  end

  describe '#portfolio' do
    it { should belong_to(:portfolio) }
  end

  describe '#github' do
    is_valid_url(:github, About.new)
  end
end
