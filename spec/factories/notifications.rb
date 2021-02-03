FactoryBot.define do
  factory :notification do
    visiter_id { 1 }
    visited_id { 2 }
    post_id { 1 }
    comment_id { 1 }
    action { '' }
    checked { false }
  end
end
