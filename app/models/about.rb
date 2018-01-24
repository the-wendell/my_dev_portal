class About < ApplicationRecord
  belongs_to :portfolio
  validates :location, :email, :github, :linkedin, :twitter, :facebook, :website,
            length: { maximum: 100 }
  validates :about_me_brief, length: { maximum: 150 }
  validates :about_me, length: { maximum: 2000 }
  validates :github, :linkedin, :facebook, :twitter, :website, url: true
end
