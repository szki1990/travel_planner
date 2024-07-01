class Memo < ApplicationRecord
  belongs_to :schedule
  validates :title, presence: true
  validates :body, presence: true
end
