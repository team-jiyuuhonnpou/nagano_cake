class Delivery < ApplicationRecord
  belongs_to :cuntomer

  validates :name, :address, :postcode, presence: true
end
