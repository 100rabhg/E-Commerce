class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key:'customer_id'
  has_many :orderItem
  has_many :product , through: :orderItem
  validates :total_price, presence: true, numericality: {greater_than: 0}
  validates :purchase_date, presence: true
  enum :status, [:received, :packed, :shipped, :delivered, :cancelled]

  before_validation :incialize_status_and_orderdate, on: :create

  def incialize_status_and_orderdate
    self.status = received
    self.purchase_date = Date.now
  end

  after_status :send_status_mail

  def send_status_mail
      # SEND MAIL TO USER IF STATUS IS UPDATE
  end
end