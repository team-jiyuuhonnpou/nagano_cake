class Order < ApplicationRecord
  has_many :order_items
  belongs_to :cuntomer

  validates :name, :address, :postcode, presence: true

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum status: {"入金待ち": 0,"入金確認": 1,"製作中": 2, "発送準備中": 3, "発送済み": 4}
end
