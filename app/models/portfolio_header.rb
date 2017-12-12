class PortfolioHeader < ApplicationRecord
  belongs_to :portfolio
  validates :header_one_color, :header_two_color,
            css_hex_color: true
  validates :header_one, :header_two, length:
            { maximum: 100 }
  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :avatar_image, AvatarImageUploader
end
