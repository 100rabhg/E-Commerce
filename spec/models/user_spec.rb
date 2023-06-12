require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Jack', role: :customer, email: 'jsmith@sample.com', password: '123456') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a role' do
    subject.role = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if name length less than 3' do
    expect(subject.name.length).to be > 2
  end

  it 'is not valid if email is not valid' do
    expect(subject.email.match?(/\A[^@\s]+@[^@\s]+\z/)).to eq(true)
  end
end
