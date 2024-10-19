class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :background_image
  has_one_attached :profile_image
  has_and_belongs_to_many :shared_books, class_name: "Book", join_table: "books_users"
  has_many :books, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :following_users, through: :active_relationships, source: :following
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :follower_users, through: :passive_relationships, source: :follower
  has_many :members, dependent: :destroy
  has_many :memberships, dependent: :destroy

  validates :email, presence: { message: "が入力されていません" }
  validates :name, presence: { message: "が入力されていません" }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image2.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image2.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    following_users.include?(other_user)
  end

  def follower?(other_user)
    follower_users.include?(other_user)
  end
end