class AddFullNameToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :full_name, :string
  end
end
