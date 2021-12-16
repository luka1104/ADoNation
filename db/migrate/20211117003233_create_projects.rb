class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.text :mainbody
      t.integer :asp_money
      t.integer :end_date
      t.string :category
      t.string :area
      t.integer :user_id

      t.timestamps
    end
  end
end
