require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.new }
  subject do
    Order.new(payment: :COD, address: 'indore', total_price: 12, pincode: '123456', state: 'mp',
              mobile_number: '1234567890', user:)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a payment' do
    subject.payment = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a address' do
    subject.address = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a total_price' do
    subject.total_price = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a pincode' do
    subject.pincode = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a state' do
    subject.state = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a mobile_number' do
    subject.mobile_number = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid if total_price is not number' do
    expect(subject.total_price.is_a?(Numeric)).to eq(true)
  end
  it 'total_price should positive' do
    expect(subject.total_price.positive?).to eq(true)
  end
  it 'pincode length should 6' do
    expect(subject.pincode.length).to eq(6)
  end
  it 'state should be min 2' do
    expect(subject.state.length).to be >= 2
  end
  it 'mobile_number length should be 10' do
    expect(subject.mobile_number.length).to eq(10)
  end
  it 'not valid if all digit is not number' do
    expect(subject.mobile_number.match?(/\A-?\d+\Z/)).to eq(true)
  end
end
