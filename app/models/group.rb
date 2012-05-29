class Group < ActiveRecord::Base
  attr_accessible :description, :name, :position, :user_access, :user_id
  
  belongs_to :user
  has_many :group_contacts
end
