class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def increment_posts_counter
    user = User.find(user_id)
    user.update(posts_counter: user.posts_counter + 1)
  end

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).first(5)
  end
end
