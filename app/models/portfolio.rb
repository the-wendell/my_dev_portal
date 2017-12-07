class Portfolio < ApplicationRecord
  validates :url, presence: true,
                  length: { minimum: 3 },
                  uniqueness: true
  belongs_to :user
end
