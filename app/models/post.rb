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

    Post.where(['title LIKE ? OR description LIKE ? OR address LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  def create_notification_like!(current_user)
    # すでに「いいね」済みか検索
    temp = Notification.where(['visiter_id = ? and visited_id = ? and post_id = ? and action = ?', current_user.id, user_id, id, 'like'])
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

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分のコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
