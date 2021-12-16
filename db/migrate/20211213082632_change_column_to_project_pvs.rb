class ChangeColumnToProjectPvs < ActiveRecord::Migration[6.1]
  def change
    add_column :project_pvs, :user_ip, :string
  end
end
