FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:password) { |n| "password" }
    trait :customer do
        role {:customer}
    end
    trait :merchant do
        role {:merchant}
    end
  end
end

FactoryBot.define do
    factory :store do
      usera
      sequence(:name) { |n| "Name#{n}" }
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
      sequence(:quantity) {|n| n}
      sequence(:price) {|n| n}
    end
end