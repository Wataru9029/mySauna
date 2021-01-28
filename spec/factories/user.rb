FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    introduction { '新米サウナーです！' }
    # テスト用にadmin属性を付与する
    trait :admin do
      admin { true }
    end
  end
end
