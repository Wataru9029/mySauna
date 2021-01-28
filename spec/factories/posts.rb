FactoryBot.define do
    factory :post do
        title { '今井湯' }
        address { '神奈川県川崎市中原区今井南町３４−２５' }
        description { '最高に整いました！' }
        site_url { 'https://www.imaiyu.com/' }
        rate { 5 }
        infection_control_rate { 5 }
        association :user, strategy: :create
    end
end
