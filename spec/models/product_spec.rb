require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:store) { Store.new }
  let(:category) { Category.new }
  subject do
    Product.new(title: 'Product title', description: 'product description', price: 10, quantity: 12, store:, category:)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a price' do
    subject.price = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a quantity' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid if quantity is not integer' do
    expect(subject.quantity.is_a?(Integer)).to eq(true)
  end
  it 'is not valid if price is not number' do
    expect(subject.price.is_a?(Numeric)).to eq(true)
  end
  it 'title should be max 20' do
    expect(subject.title.length).to be <= 20
  end
  it 'description should be max 1000' do
    expect(subject.title.length).to be <= 1000
  end
end
