class Cost < ApplicationRecord
  belongs_to :book
  validates :price, presence: true
  validates :date, presence: true
  validates :consumer, presence: true
  validates :purchase_item, presence: true
  validates :payment_method, presence: true, inclusion: { in: [0, 1, 2, 3, 4] }
  PAYMENT_METHODS = ['現金', 'クレジットカード', '電子マネー', 'ポイント', 'その他'].freeze
end
