class Contact < ActiveRecord::Base
  attr_accessible :birth_date, :first_name, :gender, :last_name, :nick_name, :source, :source_reference, :user_id
  
  def gender_name
    gender == "M" ? "Male" : "Female"
  end
end
