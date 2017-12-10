class CreateTechnologies < ActiveRecord::Migration[5.1]
  def change
    create_table :technologies do |t|
      t.string :name, limit: 20
      t.references :portfolio, foreign_key: true
      t.integer :years_exp
      t.integer :proficiency
      t.boolean :show_years_exp
      t.boolean :show_proficiency

      t.timestamps
    end
  end
end
