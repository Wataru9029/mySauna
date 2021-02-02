class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1200 }
  validates :site_url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, if: proc { |post| post.site_url.present? }
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  validates :infection_control_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, if: proc { |post| post.infection_control_rate.present? }

  acts_as_taggable
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.search(search)
    return Post.all unless search

    Post.where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
  end

  def create_notification_like!(current_user)
    # すでに「いいね」済みか検索
    temp = notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知を新規作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
    end
    # 自分の投稿に対するいいねの場合は通知済みになる
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
