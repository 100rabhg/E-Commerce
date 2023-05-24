class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true, length: {minimum: 3}
  has_one :store
  has_many :order
  has_many :cartItem
  has_many :product, through: :product

  after_create :send_welcome_mail

  def send_welcome_mail
    # send welcome mail to user and admin
    UserMailer.welcome_mail(self).deliver_now
  end
end