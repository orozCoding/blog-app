require 'rails_helper'

RSpec.describe Post, type: :model do
  example_user = User.new(name: 'Carlos',
                          photo: 'url',
                          bio: 'The Bio from Carlos',
                          posts_counter: 0)
  example_user.save

  example_post = Post.new(author_id: example_user.id, title: 'random-title', text: 'random body')

  before(:all) { example_post.save }

  describe 'validate data: ' do
    it 'title is not valid if it is empty' do
      example_post.title = ''
      expect(example_post).to_not be_valid
    end

    it 'title is not valid if length is greater than 250 characters' do
      example_post.title = 'Isla de Margarita es parte de Venezuela y se ubica en el mar Caribe, a unos 40 km al norte del continente. Es un destino vacacional popular que incluye 2 penínsulas conectadas por la arena y los manglares del parque nacional Laguna de La Restinga. La mayor parte de la gente vive o se aloja en la península oriental, donde están las ciudades de Pampatar, Porlamar y La Asunción'
      expect(example_post).to_not be_valid
    end

    it 'comments_counter is valid when value is an integer, and it is zero or greater' do
      example_post.title = 'random-title'
      example_post.comments_counter = 0
      expect(example_post).to be_valid
      example_post.comments_counter = 99
      expect(example_post).to be_valid
    end

    it 'is not valid if comments_counter value is not an integer or if it is lower than zero' do
      example_post.title = 'random-title'
      example_post.comments_counter = 'nine'
      expect(example_post).to_not be_valid
      example_post.comments_counter = -2
      expect(example_post).to_not be_valid
    end

    it 'likes_counter is valid if it is an integer equal to or greater than zero' do
      example_post.title = 'random-title'
      example_post.comments_counter = 1
      example_post.likes_counter = 0
      expect(example_post).to be_valid
      example_post.likes_counter = 45
      expect(example_post).to be_valid
    end

    it 'is not valid if likes_counter is lower than zero or not an integer' do
      example_post.title = 'random-title'
      example_post.comments_counter = 1
      example_post.likes_counter = -2
      expect(example_post).to_not be_valid
      example_post.likes_counter = 'test'
      expect(example_post).to_not be_valid
    end
  end

  describe 'recent_comments method' do
    before do
      Comment.create(post: example_post, author_id: example_user.id, text: 'one')
      Comment.create(post: example_post, author_id: example_user.id, text: 'two')
      Comment.create(post: example_post, author_id: example_user.id, text: 'three')
      Comment.create(post: example_post, author_id: example_user.id, text: 'four')
      Comment.create(post: example_post, author_id: example_user.id, text: 'five')
      Comment.create(post: example_post, author_id: example_user.id, text: 'six')
      Comment.create(post: example_post, author_id: example_user.id, text: 'seven')
      Comment.create(post: example_post, author_id: example_user.id, text: 'eight')
    end

    it 'should return up to five latest comments' do
      expect(example_post.recent_comments.length).to be(5)
      expect(example_post.recent_comments[0].text).to eq 'eight'
    end
  end
end
