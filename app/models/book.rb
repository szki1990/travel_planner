class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :schedules, dependent: :destroy
  has_many :cost, dependent: :destroy
  has_many :check_list, dependent: :destroy
  has_many :memos, dependent: :destroy

  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  
  scope :public_books, -> { where(public_status: true) }
  
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

end
