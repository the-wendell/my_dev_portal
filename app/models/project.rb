class Project < ApplicationRecord
  belongs_to :portfolio
  validates :order, numericality: { only_integer: true }
  validates :title, length: { minimum: 1, maximum: 40 }
  validates :portfolio_id, max_projects: true
  mount_uploader :image, ImageUploader
end
