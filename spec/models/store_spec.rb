require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:user) { User.new }
  subject {Store.new(name: "Jackstore", description: "jack store description", user: user)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid if name length less than 3" do
    expect(subject.name.length).to be > 2
  end

  it "is not valid if description is more than 500" do
    expect(subject.description.length).to be <= 500
  end

  # it "should belong to user" do
  #   should 
  # end
  
end
