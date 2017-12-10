class Technology < ApplicationRecord
  validates :proficiency,
            numericality: { greater_than: 0, less_than: 11}
  validates :yeras_exp,
            numericality: { greater_than_or_equal_to: 0 }
  validates :show_years_exp, :show_proficiency,
            inclusion: { in: [true, false] }
  validates :name,
            presence: true,
            length: { maximum: 20 }
  belongs_to :portfolio
end
