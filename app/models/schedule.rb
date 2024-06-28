class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :categories, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :costs, dependent: :destroy
  has_many :items, dependent: :destroy
end
