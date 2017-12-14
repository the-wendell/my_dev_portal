class About < ApplicationRecord
  belongs_to :portfolio
  validates :about_me_brief, length: { maximum: 150 }
  validates :about_me, length: { maximum: 2000 }
end
