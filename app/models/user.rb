class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  encrypts :private_api_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :api

  validates :name, presence: true, length: { minimum: 3 }
  validates :private_api_key, uniqueness: true, allow_blank: true

  has_one :store, dependent: :destroy
  has_many :orders
  has_many :cartItems, dependent: :destroy

  enum :role, %i[merchant customer]

  after_create :send_welcome_mail
  before_create :set_private_api_key

  private

  def send_welcome_mail
    # send welcome mail to user and admin
    UserMailer.welcome_mail(self).deliver_now
    SendMailWorker.new.perform(self)
  end

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end

end
