class PortfolioHeader < ApplicationRecord
  belongs_to :portfolio
  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :avatar_image, AvatarImageUploader
end
