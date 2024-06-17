class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :recoverable
         
  has_one_attached :profile_image
  
  has_many :books, dependent: :destroy
  
  validates :email, presence: { message: "が入力されていません" }
  validates :name, presence: { message: "が入力されていません" }
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/25145460.jpg')
      profile_image.attach(io: File.open(file_path), filename: '25145460.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end 
  
end
