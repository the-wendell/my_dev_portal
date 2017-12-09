require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) { user.portfolios.create(url: 'testing') }
  let(:project_input) do
    { title: 'My title',
      descrption: 'So many words',
      role: 'supreme leader',
      link: 'the-fun-place',
      tech: 'mostly interent explorer' }
  end

  describe 'Create Project' do
    it 'creates new project' do
      portfolio.projects.create(project_input)
      expect(portfolio.projects.all.count).to eq(1)
    end
    it 'uploads image using ImageUploader' do
      image = fixture_file_upload('images/test.jpg')
      portfolio.projects.create(image: image)
      expect(portfolio.projects.first.image.is_a?(ImageUploader)).to eq(true)
    end
    it 'requires a portfolio' do
      Project.create(project_input)
      expect(Project.all.count).to eq(0)
    end
  end
  describe 'Update Project' do
    let(:project) { portfolio.projects.create(project_input) }
    it 'updates a project' do
      project.update(title: 'updated')
      expect(portfolio.projects.first.title).to eq('updated')
    end
  end
end
