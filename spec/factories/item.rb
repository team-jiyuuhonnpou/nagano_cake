FactoryBot.define do
  factory :item do
    image { File.open("#{Rails.root}/spec/fixtures/img/no-image.png") }
    item_name { "ロールケーキ" }
    explanation { "ロールケーキ" }
    non_taxed_price { 100 }
    is_active { true }
    association :genre
  end
end
