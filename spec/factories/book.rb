FactoryBot.define do
  factory :book do
    title { "デフォルトのタイトル" }
    start_day { "2024-09-20" }
    end_day { "2024-09-20" }
    public_status { "公開" }
    association :user
  end
end
