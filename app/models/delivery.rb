class Delivery < ApplicationRecord
  belongs_to :customer, optional: true

  validates :name, :address, :postcode, presence: true
end
