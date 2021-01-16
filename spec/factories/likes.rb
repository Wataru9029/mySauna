FactoryBot.define do
  factory :like do
    association :post, strategy: :create
    association :user, strategy: :create
  end
end
