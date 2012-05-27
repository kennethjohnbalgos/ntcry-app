class ChangePrimaryDataTypeToActive < ActiveRecord::Migration
  def up
    change_table :group_contacts do |t|
      t.change :active, :integer
    end
  end

  def down
    change_table :group_contacts do |t|
      t.change :active, :boolean
    end
  end
end
