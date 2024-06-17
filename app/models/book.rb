class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true

  validates :public, inclusion: { in: [true, false] }
  scope :posts, -> { where(public: true) }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/25145457.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg',content_type: 'image/jpeg')
    end
    image
  end

end
