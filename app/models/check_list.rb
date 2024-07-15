class CheckList < ApplicationRecord
  belongs_to :book
  has_many :categories, dependent: :destroy
  
  validates :title, presence: true
end
