class AddStatusToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :status, :string, default: 'new'
  end
end
