class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  mount_uploader :image, ImageUploader

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1200 }
  validates :site_url, format: /\A#{URI::regexp(%w(http https))}\z/, if: Proc.new { |post| post.site_url.present? }
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  validates :infection_control_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, if: Proc.new { |post| post.infection_control_rate.present? }

  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
