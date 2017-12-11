class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :portfolio, foreign_key: true
      t.string :title
      t.string :link
      t.text :descrption
      t.string :image
      t.text :tech
      t.string :role
      t.integer :order

      t.timestamps
    end
  end
end
