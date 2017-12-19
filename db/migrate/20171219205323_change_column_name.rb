class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :description, :description
  end
end
