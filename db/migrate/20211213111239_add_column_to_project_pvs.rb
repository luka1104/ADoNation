class AddColumnToProjectPvs < ActiveRecord::Migration[6.1]
  def change
    add_column :project_pvs, :created_date, :string
  end
end
