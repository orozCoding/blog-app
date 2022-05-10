class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, length: { maximum: 250 }, presence: true
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  after_save :increment_posts_counter
end
