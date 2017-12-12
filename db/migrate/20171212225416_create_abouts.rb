class CreateAbouts < ActiveRecord::Migration[5.1]
  def change
    create_table :abouts do |t|
      t.references :portfolio, foreign_key: true
      t.text :about_me
      t.string :location
      t.string :about_me_brief

      t.timestamps
    end
  end
end
