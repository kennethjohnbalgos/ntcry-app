class ChangePrimaryDataTypeToInteger < ActiveRecord::Migration
  def up
    change_table :email_addresses do |t|
      t.change :primary, :integer
    end
  end

  def down
    change_table :email_addresses do |t|
      t.change :primary, :boolean
    end
  end
end
