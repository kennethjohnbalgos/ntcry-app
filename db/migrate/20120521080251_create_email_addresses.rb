class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.integer :contact_id
      t.string :email
      t.string :provider
      t.string :status
      t.boolean :primary

      t.timestamps
    end
  end
end
