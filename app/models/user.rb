class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :subscription,
          date: { after_or_equal_to: Proc.new { Date.today },
                  before: Proc.new { Date.new(Date.today.year+4, Date.today.month, Date.today.day) },
                  message: "date is not valid" }

  scope :first_name, -> (first_name) { where("first_name like ?", "%#{first_name}%") }
  scope :last_name, -> (last_name) { where("last_name like ?", "%#{last_name}%") }
  scope :email, -> (email) { where("email like ?", "%#{email}%") }
  
  def is_subscription_active?
    subscription >= Date.today
  end
end
