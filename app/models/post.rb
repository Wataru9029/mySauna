class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 1200 }
  validates :site_url, length: { maximum: 200 }, format: /\A#{URI::regexp(%w(http https))}\z/

  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
