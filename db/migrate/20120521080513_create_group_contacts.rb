class CreateGroupContacts < ActiveRecord::Migration
  def change
    create_table :group_contacts do |t|
      t.integer :group_id
      t.integer :contact_id
      t.integer :position
      t.boolean :active

      t.timestamps
    end
  end
end
