FactoryBot.define do
  factory :recipe do
    title { 'Title for testing' }
    description { 'Description for testing' }
    user
  end
end
