class Group < ActiveRecord::Base
  attr_accessible :description, :name, :position, :user_access, :user_id
end
