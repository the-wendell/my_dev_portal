require 'rails_helper'

RSpec.describe PortfolioHeader, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:portfolio) { user.portfolios.create(url: 'testing') }
  let(:attributes) do
    { header_one: 'testing title',
      header_two: 'exiting stuff',
      header_two_color: '#ffffff',
      header_one_color: '#ffffff',
      portfolio_id: portfolio.id }
  end

  describe '#create' do
    it 'creates new portfolio_header' do
      PortfolioHeader.create(attributes)
      expect(PortfolioHeader.all.count).to eq(1)
    end
    it 'uploads image using CoverImageUploader' do
      image = fixture_file_upload('images/test.jpg')
      record = PortfolioHeader.new(attributes)
      record.cover_image = image
      record.save
      expect(PortfolioHeader.first.cover_image.is_a?(CoverImageUploader)).to eq(true)
    end
    it 'uploads image using AvatarImageUploader' do
      image = fixture_file_upload('images/test.jpg')
      record = PortfolioHeader.new(attributes)
      record.avatar_image = image
      record.save
      expect(PortfolioHeader.first.avatar_image.is_a?(AvatarImageUploader)).to eq(true)
    end
  end

  describe '#update' do
    let(:portfolio_header) { PortfolioHeader.create(attributes) }
    it 'updates a portfolio_header' do
      portfolio_header.update(header_one: 'updated')
      expect(PortfolioHeader.first.header_one).to eq('updated')
    end
  end

  describe '#header_one' do
    it do
      should validate_length_of(:header_one)
        .is_at_most(100)
    end
  end

  describe '#header_two' do
    it do
      should validate_length_of(:header_two)
        .is_at_most(100)
    end
  end

  describe '#header_two_color' do
    it 'validates valid CSS hex color' do
      record = PortfolioHeader.new
      record.header_two_color = '#kjhadk'
      record.valid?
      expect(record.errors[:header_two_color]).to eq(["must be a valid CSS hex color code"])

      record.header_two_color = 123123
      record.valid?
      expect(record.errors[:header_two_color]).to eq(["must be a valid CSS hex color code"])

      record.header_two_color = '#123456'
      record.valid?
      expect(record.errors[:header_two_color]).to eq([])
    end
  end

  describe '#header_one_color' do
    it 'validates valid CSS hex color' do
      record = PortfolioHeader.new
      record.header_one_color = '#kjhadk'
      record.valid?
      expect(record.errors[:header_one_color]).to eq(["must be a valid CSS hex color code"])

      record.header_one_color = 123123
      record.valid?
      expect(record.errors[:header_one_color]).to eq(["must be a valid CSS hex color code"])

      record.header_one_color = '#123456'
      record.valid?
      expect(record.errors[:header_one_color]).to eq([])
    end
  end

  describe '#portfolio' do
    it { should belong_to(:portfolio) }
  end
end
