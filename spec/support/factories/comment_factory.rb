FactoryBot.define do
  factory :comment do
    association(:post)
    association(:user)
    body { 'nice post!!!' }
  end
end