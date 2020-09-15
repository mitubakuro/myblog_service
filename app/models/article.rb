class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :image
  has_rich_text :body
  belongs_to :user
  acts_as_taggable

  def self.search(search)
    if search != ''
      Article.where('title LIKE(?)', "%#{search}%")
    else
      Article.all
    end
  end
end
