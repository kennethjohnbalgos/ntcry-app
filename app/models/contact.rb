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
end
