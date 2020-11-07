FactoryBot.define do
  factory :instruction do
    sequence(:order) { |n| n }
    instruction_info { 'Instruction test' }
    recipe
  end
end
