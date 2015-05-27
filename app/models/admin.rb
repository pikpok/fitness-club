class Admin < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable, :validatable

  validates :email, uniqueness: true, presence: true
end
