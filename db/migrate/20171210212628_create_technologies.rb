class CreateTechnologies < ActiveRecord::Migration[5.1]
  def change
    create_table :technologies do |t|
      t.string :name, limit: 20
      t.references :portfolio, foreign_key: true
      t.integer :years_exp
      t.integer :proficiency

      t.timestamps
    end
  end
end
