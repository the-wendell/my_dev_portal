require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) { FactoryGirl.create(:portfolio, user: user) }
  let(:project_input) do
    { title: 'My title',
      descrption: 'So many words',
      role: 'supreme leader',
      link: 'the-fun-place',
      tech: 'mostly interent explorer',
      order: 1 }
  end

  describe '#create' do
    it 'creates new project' do
      portfolio.projects.create(project_input)
      expect(portfolio.projects.all.count).to eq(1)
    end
    it 'uploads image using ImageUploader' do
      image = fixture_file_upload('images/test.jpg')
      portfolio.projects.create(image: image)
      expect(portfolio.projects.first.image.is_a?(ImageUploader)).to eq(true)
    end
  end

  describe '#update' do
    let(:project) { portfolio.projects.create(project_input) }
    it 'updates a project' do
      project.update(title: 'updated')
      expect(portfolio.projects.first.title).to eq('updated')
    end
  end

  describe '#portfolio' do
    it { should belong_to(:portfolio) }
  end

  describe '#order' do
    it { should validate_numericality_of(:order) }
  end
end
