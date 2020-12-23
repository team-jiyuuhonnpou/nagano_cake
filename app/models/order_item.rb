class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_id, :order_id, :amount, :price, presence: true

  enum production_status: {"制作不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}
end