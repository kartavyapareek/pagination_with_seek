FactoryBot.define do
  factory :employee do
    sequence(:identification_number) { |n| n }
    full_name { Faker::Name.name }
  end
end