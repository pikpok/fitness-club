class Receptionist < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :timeoutable, :lockable, :validatable

  validates :email, uniqueness: true, presence: true
end
