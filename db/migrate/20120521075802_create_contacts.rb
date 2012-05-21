class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :gender
      t.date :birth_date
      t.string :source
      t.string :source_reference

      t.timestamps
    end
  end
end
