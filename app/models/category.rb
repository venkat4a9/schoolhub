class Category < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_accessible :name, :parent_id
  

end
