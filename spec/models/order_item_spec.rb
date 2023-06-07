require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order) { Order.new }
  let(:product) { Product.new(price:1) }
  subject {OrderItem.new( quantity: 10,order: order, product: product )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a quantity" do
    subject.quantity=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if quantity is not number" do
    expect(subject.quantity.is_a? Integer).to eq(true)
  end
  it "quantity should positive" do
    expect(subject.quantity.positive?).to eq(true)
  end
end