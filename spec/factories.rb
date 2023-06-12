require 'faker'

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    email { Faker::Internet.email }
    password { 'password' }
    trait :customer do
      role { :customer }
    end
    trait :merchant do
      role { :merchant }
    end
    confirmed_at { Time.now }
  end
end

FactoryBot.define do
  factory :store do
    user
    name { Faker::Name.unique.name }
    sequence(:description) { |n| "Description#{n}" }
  end
end

FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Title#{n}" }
  end
end

FactoryBot.define do
  factory :product do
    store
    category
    sequence(:title) { |n| "Title#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:quantity) { |n| n }
    sequence(:price) { |n| n }
  end
end

FactoryBot.define do
  factory :order do
    user
    total_price { Faker::Number.decimal }
    purchase_date { Date.today }
    status { :received }
    sequence(:address) { |n| "Address#{n}" }
    mobile_number { Faker::Number.number(digits: 10) }
    pincode { Faker::Number.number(digits: 6) }
    state { Faker::String.random(length: 4) }
    payment { :COD }
  end
end

FactoryBot.define do
  factory :cartItem do
    user
    product
    quantity { Faker::Number.number }
    sub_total { Faker::Number.decimal }
  end
end
