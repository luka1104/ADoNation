class CreateProjectPvs < ActiveRecord::Migration[6.1]
  def change
    create_table :project_pvs do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
