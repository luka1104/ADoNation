class RemoveTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :project_pvs
  end
end
