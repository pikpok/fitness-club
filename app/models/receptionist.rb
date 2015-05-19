class Receptionist < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :timeoutable, :lockable

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
