class Portfolio < ApplicationRecord
  validates :url, presence: true,
                  length: { in: 3..30 },
                  uniqueness: true
  belongs_to :user
  has_many :projects
  has_many :technologies
end
