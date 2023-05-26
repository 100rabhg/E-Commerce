class Order < ApplicationRecord
  belongs_to :user
  has_many :orderItem, dependent: :destroy
  has_many :product, through: :orderItem
  validates :total_price, presence: true, numericality: { minmum: 1 }
  validates :purchase_date, presence: true
  enum :status, %i[received packed shipped delivered cancelled]

  before_validation :incialize_status_and_orderdate, on: :create

  def incialize_status_and_orderdate
    self.status = :received
    self.purchase_date = Date.today
  end

  after_save :send_status_mail

  def send_status_mail
    OrderMailer.send_status_mail(self).deliver_later
  end
end
