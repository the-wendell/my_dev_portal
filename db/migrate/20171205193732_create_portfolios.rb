class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.references :user, foreign_key: true
      t.string :url

      t.timestamps
    end
    add_index :portfolios, :url, unique: true
  end
end
