class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true
  has_many :categories, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :costs, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validate :dates_within_book_range

  def dates_within_book_range
    unless start_date.present? && book &&
            book.start_day <= start_date &&
            start_date <= book.end_day
      errors.add(:base, "スケジュールの日付はしおりの範囲内で指定してください")
    end
  end

end
