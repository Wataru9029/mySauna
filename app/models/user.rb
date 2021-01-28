class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', inverse_of: 'user', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: false, length: { maximum: 255 }

  def self.guest
    find_or_create_by!(email: 'guest@com') do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.image = File.open('./app/assets/images/saunner.jpeg')
    end
  end

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def feed
    following_ids = "SELECT follow_id FROM relationships
                     WHERE user_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
