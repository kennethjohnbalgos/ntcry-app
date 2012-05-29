class Group < ActiveRecord::Base
  attr_accessible :description, :name, :position, :user_access, :user_id
  
  validates_presence_of :name, :description
  validates_length_of :name, :maximum => 15
  validates_length_of :description, :maximum => 150
  
  belongs_to :user
  has_many :group_contacts
end
