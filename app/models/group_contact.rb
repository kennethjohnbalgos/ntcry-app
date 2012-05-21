class GroupContact < ActiveRecord::Base
  attr_accessible :active, :contact_id, :group_id, :position
end
