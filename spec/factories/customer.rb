FactoryBot.define do
  factory :customer do
    last_name { "テスト" }
    first_name { "太郎" }
    kana_last_name { "テスト" }
    kana_first_name { "タロウ" }
    password { "123456" }
    email { "test@icloud.com" }
    postcode { "1000000" }
    street_address { "東京都" }
    phone_number { "123456789" }
    is_unsubscribed { false }
  end
end
