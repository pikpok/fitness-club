class Admin < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable, :validatable

  validates :email, uniqueness: true, presence: true 
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
