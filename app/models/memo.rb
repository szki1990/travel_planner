class Memo < ApplicationRecord
  belongs_to :schedule
  belongs_to :book
  validates :title, presence: true
  validates :body, presence: true
end
