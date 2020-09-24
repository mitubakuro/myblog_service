class Article < ApplicationRecord
  has_one_attached :image
  has_rich_text :body
  belongs_to :user
  acts_as_taggable
  enum status: {released: 0, unreleased: 1}
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def self.search(search)
    if search != ''
      Article.where('title LIKE(?)', "%#{search}%").order(created_at: :desc)
    else
      Article.all.order(created_at: :desc)
    end
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
