class Project < ApplicationRecord
  belongs_to :portfolio
  validates :order, numericality: { only_integer: true }
  mount_uploader :image, ImageUploader
end
