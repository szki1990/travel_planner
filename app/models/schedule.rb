class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :address, presence: true
  validate :dates_within_book_range

  def dates_within_book_range
    unless start_date.present? && book &&
            book.start_day <= start_date &&
            start_date <= book.end_day
      errors.add(:base, "スケジュールの日付はしおりの範囲内で指定してください")
    end
  end
  
  has_one_attached :image
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
