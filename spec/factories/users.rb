# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "pepito#{n}@test.com" }
    sequence(:name) {|n| "pepito#{n}" }
  end
end
