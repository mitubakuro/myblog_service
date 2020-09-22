class Article < ApplicationRecord
  has_one_attached :image
  has_rich_text :body
  belongs_to :user
  acts_as_taggable
  enum status: {released: 0, unreleased: 1}
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :title, presence: true
  validates :body, presence: true

  def self.search(search)
    if search != ''
      Article.where('title LIKE(?)', "%#{search}%").order(created_at: :desc)
    else
      Article.all.order(created_at: :desc)
    end
  end
end
