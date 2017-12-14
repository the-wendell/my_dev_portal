class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.references :user, foreign_key: true
      t.string :url
      t.string :theme
      t.string :color_one
      t.string :color_two
      t.string :color_three
      t.string :color_four
      t.string :font_color_one
      t.string :font_color_two
      t.boolean :show_cover_image
      t.boolean :show_avatar_image

      t.timestamps
    end
    add_index :portfolios, :url, unique: true
  end
end
