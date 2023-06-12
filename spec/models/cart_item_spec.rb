require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:user) { User.new }
  let(:product) { Product.new }
  subject { CartItem.new(quantity: 10, user:, product:) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a quantity' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end
end
