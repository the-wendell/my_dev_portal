class CreatePortfolioHeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolio_headers do |t|
      t.belongs_to :portfolio, index: true
      t.string :header_one
      t.string :header_one_color
      t.string :header_two
      t.string :header_two_color
      t.string :cover_image
      t.string :avatar_image

      t.timestamps
    end
  end
end
