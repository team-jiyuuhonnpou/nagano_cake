class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :item_id, :customer_id, :amount, presence: true
  # 1以上の整数のみ許可
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  
<<<<<<< HEAD
end
=======
end
>>>>>>> 374fe349c8f7e2a2411d6f45ce3b2f6f1a0b83ae
