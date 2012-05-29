class GroupContact < ActiveRecord::Base
  attr_accessible :active, :contact_id, :group_id, :position
  
  belongs_to :group
end
