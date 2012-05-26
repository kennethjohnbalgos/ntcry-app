class Contact < ActiveRecord::Base
  attr_accessible :birth_date, :first_name, :gender, :last_name, :nick_name, :source, :source_reference, :user_id
  
  validates_presence_of :first_name, :last_name
  
  def gender_name
    if gender.present?
      gender == "M" ? "Male" : "Female"
    else
      gender = ""
    end
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def complete_name
    if nick_name.present?
      "#{full_name} - #{nick_name}"
    else
      "#{full_name}"
    end
  end
end
