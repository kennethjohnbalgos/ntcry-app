class Contact < ActiveRecord::Base
  attr_accessible :birth_date, :first_name, :gender, :last_name, :nick_name, :source, 
    :source_reference, :user_id, :full_name
  
  has_many :email_addresses
  belongs_to :user
  
  validates_presence_of :full_name
  
  def gender_name
    if gender.present?
      gender == "M" ? "Male" : "Female"
    else
      gender = ""
    end
  end
  
  def primary_email
    if self.email_addresses.count > 0
      self.email_addresses.where(main: 1).first.email
    else
      nil
    end
  end
  
  def valid_email_addresses
    self.email_addresses.where("status <> 'deleted'")
  end
  
  def complete_name
    if nick_name.present?
      "#{full_name} - #{nick_name}"
    else
      "#{full_name}"
    end
  end
end
