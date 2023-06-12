FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'soop3rs3cur3' }
    first_name { 'Person' }
    last_name { 'Dude' }
  end
end