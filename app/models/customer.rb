class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries
  has_many :orders
  has_many :cart_items

  validates :last_name, :first_name, :kana_last_name, :kana_first_name,
            :street_address, :encrypted_password, :email, :phone_number,
            presence: true

end
