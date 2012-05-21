class EmailAddress < ActiveRecord::Base
  attr_accessible :contact_id, :email, :primary, :provider, :status
end
