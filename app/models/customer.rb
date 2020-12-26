class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries
  has_many :orders
  has_many :cart_items

  validates :last_name, :first_name, :kana_last_name, :kana_first_name, :postcode,
            :street_address, :encrypted_password, :email, :phone_number,
            presence: true
            
  # 全角カタカナ
  VALID_KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :kana_last_name, :kana_first_name, format: { with: VALID_KATAKANA_REGEX }
  # メールアドレス
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  # 郵便番号（ハイフンなし7桁）
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :postcode, format: { with: VALID_POSTCODE_REGEX }
  # 電話番号(ハイフンなし10桁or11桁)
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }

  # customerのis_unsubscribedがfalseならtrueを返す
  def active_for_authentication?
    super && (self.is_unsubscribed == false)
  end

end
