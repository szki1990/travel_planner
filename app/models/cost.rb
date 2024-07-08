class Cost < ApplicationRecord
  belongs_to :book
  validates :price, presence: true
  validates :date, presence: true
  validates :payment_method, presence: true
  PAYMENT_METHODS = ['クレジットカード', '現金', '電子マネー', 'ポイント', 'その他'].freeze
end
