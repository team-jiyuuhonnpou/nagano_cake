class Delivery < ApplicationRecord
  belongs_to :customer, optional: true

  validates :customer_id, :name, :address, :postcode, presence: true
  # 郵便番号（ハイフンなし7桁）
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :postcode, format: { with: VALID_POSTCODE_REGEX }
end
