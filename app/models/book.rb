class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :schedules, dependent: :destroy
  has_many :costs, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  
  #scope :public_books, -> { where(public_status: true) }
  
  def date_range
    (start_day.to_date..end_day.to_date).to_a
  end 


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  
  validate :validate_date_range_order
  
  private
  
  def validate_date_range_order
    if start_day.present? && end_day.present? && end_day < start_day
      errors.add(:end_day, "は開始日より後の日付を指定してください")
    end 
  end 

end
