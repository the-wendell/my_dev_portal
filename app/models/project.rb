class Project < ApplicationRecord
  belongs_to :portfolio
  validates :link, :role, length: { maximum: 200 }
  validates :tech, length: { maximum: 500 }
  validates :description, length: { maximum: 2000 }
  validates :order, numericality: { only_integer: true, greater_than: 0, less_than: 20 }
  validates :title, length: { minimum: 1, maximum: 40 }
  validates :portfolio_id, max_projects: true
  mount_uploader :image, ImageUploader
end
