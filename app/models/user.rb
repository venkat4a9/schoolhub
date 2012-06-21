class User < ActiveRecord::Base
  has_and_belongs_to_many :categories
  
  attr_accessible :email, :name, :password, :password_confirmation, :category_ids
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
end
