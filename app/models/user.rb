class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments

  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: false, length: { maximum: 255 }

  def self.guest
    find_or_create_by!(email: "guest@com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
