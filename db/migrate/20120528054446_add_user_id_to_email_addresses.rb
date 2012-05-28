class AddUserIdToEmailAddresses < ActiveRecord::Migration
  def change
    add_column :email_addresses, :user_id, :integer
  end
end
