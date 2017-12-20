class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :descrption, :description
  end
end
