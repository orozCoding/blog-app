class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end

  after_save :increment_comments_counter
end
