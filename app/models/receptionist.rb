class Receptionist < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :timeoutable, :lockable, :validatable

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
