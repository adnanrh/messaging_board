FactoryBot.define do
  factory :post do
    association(:user)
    title { 'nice' }
    body { 'great' }
  end
end