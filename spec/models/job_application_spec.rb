require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) do
    { first_contact_date: '2017-08-04',
      company_name: 'The First Order',
      job_location: 'Remote',
      enthusiasm: 'high',
      job_title: 'Supreme Leader',
      referral: 'Snoke',
      referral_type: 'mentor',
      status: 'applied',
      industry: 'ruling the galaxy' }
  end

  describe '#create' do
    it 'creates new project' do
      user.job_applications.create(valid_attributes)
      expect(user.job_applications.all.count).to eq(1)
    end
  end

  describe '#update' do
    let(:job_application) { user.job_applications.create(valid_attributes) }
    it 'updates a project' do
      job_application.update(company_name: 'Rebal Alliance')
      expect(user.job_applications.first.company_name).to eq('Rebal Alliance')
    end
  end

  describe '#user' do
    it { should belong_to(:user) }
  end

  describe '#enthusiasm' do
    it do
      should validate_inclusion_of(:enthusiasm)
        .in_array(%w[high medium low])
    end
  end

  describe '#status' do
    it do
      should validate_inclusion_of(:status)
        .in_array(%w[researching applied interviewing rejected offer])
    end
  end

  describe '#referral_type' do
    it do
      should validate_inclusion_of(:referral_type)
        .in_array(['cold outreach', 'mentor', 'personal connection', 'new connection', 'career website'])
    end
  end

  describe '#company_name' do
    it do
      should validate_length_of(:company_name)
        .is_at_most(100)
    end
  end

  describe '#company_website' do
    it do
      should validate_length_of(:company_website)
        .is_at_most(100)
    end
  end

  describe '#job_location' do
    it do
      should validate_length_of(:job_location)
        .is_at_most(100)
    end
  end

  describe '#job_title' do
    it do
      should validate_length_of(:job_title)
        .is_at_most(100)
    end
  end

  describe '#referral' do
    it do
      should validate_length_of(:referral)
        .is_at_most(100)
    end
  end

  describe '#industry' do
    it do
      should validate_length_of(:industry)
        .is_at_most(100)
    end
  end

  describe '#notes' do
    it do
      should validate_length_of(:notes)
        .is_at_most(1000)
    end
  end

  describe '#job_link' do
    it do
      should validate_length_of(:job_link)
        .is_at_most(250)
    end
  end
end
