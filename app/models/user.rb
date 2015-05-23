class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :telephone, presence: :true, length: 9..9, numericality: true
  validates :subscription,
          date: { after_or_equal_to: Date.new(2015, 05, 14),
                  before: Date.new(2100, 12, 31),
                  message: "date is not valid" }

  scope :first_name, -> (first_name) { where("lower(first_name) like ?", "%#{first_name.mb_chars.downcase.to_s}%") }
  scope :last_name, -> (last_name) { where("lower(last_name) like ?", "%#{last_name.mb_chars.downcase.to_s}%") }
  scope :email, -> (email) { where("lower(email) like ?", "%#{email.downcase}%") }
  
  def is_subscription_active?
    subscription >= Date.today
  end

  def subscription_days_left
    is_subscription_active? ? (subscription - Date.today).to_i : 0
  end
end
