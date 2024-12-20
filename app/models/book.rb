class Book < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :shared_users, class_name: "User", join_table: "books_users"
  attr_accessor :shared_with
  has_one_attached :image
  has_many :schedules, dependent: :destroy
  has_many :costs, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :members, dependent: :destroy

  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true

  geocoded_by :address
  after_validation :geocode

  scope :publicly_visible, -> { where(public_status: true) }
  scope :privately_visible, -> { where(public_status: false) }
  
  after_create do
    if public_status
      user.follower_users.each do |follower|
        notifications.create(user_id: follower.id)
      end 
    end
  end

  def date_range
    (start_day.to_date..end_day.to_date).to_a
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image
  end

  def publicly_visible?
    public_status == true
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def accessible_by?(user)
    user == self.user || shared_users.include?(user)
  end

  def remove_image
    self.image.purge
  end
  
  def profile_image_url
    if profile_image.attached?
      "https://pf-travelp-resized-bucket.s3-ap-northeast-1.amazonaws.com/#{@user.profile_image.key}-thumbnail.#{@user.profile_image.blob.content_type.split('/').pop}"
    else 
      ActionController::Base.helpers.asset_path('default-image2.jpg')
    end 
  end

  validate :validate_date_range_order

  private
    def validate_date_range_order
      if start_day.present? && end_day.present? && end_day < start_day
        errors.add(:end_day, "は開始日より後の日付を指定してください")
      end
    end
end
