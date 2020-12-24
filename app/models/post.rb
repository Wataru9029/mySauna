class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 1200 }
  validates :site_url, length: { maximum: 200 }, format: /\A#{URI::regexp(%w(http https))}\z/
end
