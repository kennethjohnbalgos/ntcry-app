class EmailAddress < ActiveRecord::Base
  attr_accessible :contact_id, :email, :main, :provider, :status, :user_id
  
  has_one :contact
  belongs_to :user
  
  validates_presence_of :email
  
  
end
