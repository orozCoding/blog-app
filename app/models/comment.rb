class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def increment_comments_counter
    post = Post.find(post_id)
    post.update(comments_counter: post.comments_counter + 1)
  end
end
