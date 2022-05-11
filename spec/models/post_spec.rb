require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validate data: ' do
    User.destroy_all
    Post.destroy_all
    User.delete_all
    Post.delete_all

    example_user = User.create(id: 1, username: 'angel', email: 'test@test.com', name: 'Mr. Test', password: 'password',
                               password_confirmation: 'password')

    example_post = Post.create(id: 1, author: example_user, title: 'La vida', text: 'Es bella')

    it 'title is not valid if it is empty' do
      example_post.title = ''

      expect(example_post).to_not be_valid
    end

    it 'title is not valid if length is greater than 250 characters' do
      example_post.title = 'Isla de Margarita es parte de Venezuela y se ubica en el mar Caribe, a unos 40 km al norte del continente.
      Es un destino vacacional popular que incluye 2 penínsulas conectadas por la arena y los manglares del parque nacional Laguna de La Restinga.
      La mayor parte de la gente vive o se aloja en la península oriental, donde están las ciudades de Pampatar, Porlamar y La Asunción'
      expect(example_post).to_not be_valid
    end

    it 'comments_counter is valid when value is an integer, and it is zero or greater' do
      example_post.title = 'random-title'
      example_post.likes_counter = 0
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
    User.destroy_all
    Post.destroy_all
    User.delete_all
    Post.delete_all
  end

  describe 'recent_comments method' do
    it 'should return up to five latest comments' do
      example_user = User.create(id: 1, username: 'angel', email: 'test@test.com', name: 'Mr. Test', password: 'password',
                                 password_confirmation: 'password')
      example_user.save

      example_post = Post.create(id: 1, author: example_user, title: 'La vida', text: 'Es bella')

      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'one')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'two')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'three')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'four')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'five')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'six')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'seven')
      Comment.create(post_id: example_post.id, author_id: example_user.id, text: 'eight')
      expect(example_post.recent_comments[0].text).to eq 'eight'
      expect(example_post.recent_comments.length).to eq(5)
    end
  end
end
