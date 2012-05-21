class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.integer :position
      t.string :user_access

      t.timestamps
    end
  end
end
