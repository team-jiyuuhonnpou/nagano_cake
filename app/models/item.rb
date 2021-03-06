class Item < ApplicationRecord
  has_many :order_items
  has_many :cart_items
  belongs_to :genre

  attachment :image

  validates :genre_id, :item_name, :explanation, :image, :non_taxed_price, presence: true
end
