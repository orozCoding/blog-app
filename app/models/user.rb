class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def recent_posts
    Post.where(user_id: id).order(created_at: :desc).first(3)
  end
end
