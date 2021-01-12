FactoryBot.define do
    factory :user do
        sequence(:name) { |n| "テストユーザー#{n}"}
        sequence(:email) { |n| "TEST#{n}@example.com"}
        password { "password" }
        password_confirmation { "password" }
        introduction { "新米サウナーです！" }
    end
end