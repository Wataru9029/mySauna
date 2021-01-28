FactoryBot.define do
    factory :comment do
        content { '素敵なサウナですね！' }
        association :post, strategy: :create
        user { post.user }
    end
end
