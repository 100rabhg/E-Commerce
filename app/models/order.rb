class Order < ApplicationRecord
  belongs_to :user
  has_many :orderItems, dependent: :destroy
  has_many :products, through: :orderItems

  validates :purchase_date, :payment, :address, :status, presence: true
  validates :total_price, presence: true, numericality: { minmum: 1 }
  validates :pincode, presence: true, length: { is: 6 }, format: { with: /\A-?\d+\Z/,
                                                                   message: 'only allows number' }
  validates :state, presence: true, length: { minimum: 2 }
  validates :mobile_number, presence: true, length: { is: 10 }, format: { with: /\A-?\d+\Z/,
                                                                          message: 'only allows number' }
  enum :status, %i[received packed shipped delivered cancelled]
  enum :payment, %i[COD card upi]

  before_validation :incialize_status_and_orderdate, on: :create
  after_save :send_status_mail

  private

  def incialize_status_and_orderdate
    self.status = :received
    self.purchase_date = Date.today
  end

  def send_status_mail
    OrderMailer.send_status_mail(self).deliver_now
  end
end
