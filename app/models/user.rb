class User < ApplicationRecord
  encrypts :private_api_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :api

  validates :name, presence: true, length: { minimum: 3 }
  validates :role, presence: true
  validates :private_api_key, uniqueness: true, allow_blank: true

  has_one :store, dependent: :destroy
  has_many :orders
  has_many :cartItems, dependent: :destroy

  enum :role, %i[merchant customer]

  after_create :send_welcome_mail

  private

  def send_welcome_mail
    WelcomeMailJob.set(wait_untill:Time.now+30.second).perform_later(self)
  end
end
