class Cost < ApplicationRecord
  belongs_to :book
  PAYMENT_METHODS = ['クレジットカード', 'ポイント', '現金', '電子マネー'].freeze
end
