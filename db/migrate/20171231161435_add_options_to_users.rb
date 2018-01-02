class AddOptionsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :options, :text
  end
end
