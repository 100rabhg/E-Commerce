class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  validates :name, presence: true, length: { minimum: 3 }

  has_one :store, dependent: :destroy
  has_many :orders
  has_many :cartItems, dependent: :destroy

  enum :role, %i[merchant customer]

  after_create :send_welcome_mail

  private

  def send_welcome_mail
    # send welcome mail to user and admin
    UserMailer.welcome_mail(self).deliver_now
  end
end
