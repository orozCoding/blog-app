class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  after_save :increment_comments_counter
end
