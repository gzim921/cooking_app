FactoryBot.define do
  factory :user do
    first_name { 'Name' }
    last_name { 'test' }
    sequence(:email) { |n| "testing#{n}@gmail.com" }
    password { 'Test123!' }
    password_confirmation { 'Test123!' }
  end
end
