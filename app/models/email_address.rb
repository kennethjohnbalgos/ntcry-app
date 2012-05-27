class EmailAddress < ActiveRecord::Base
  attr_accessible :contact_id, :email, :main, :provider, :status
  
  has_one :contact
  
end
