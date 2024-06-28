class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true
  has_many :categories, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :costs, dependent: :destroy
  has_many :items, dependent: :destroy
  
  validates :title, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
end
