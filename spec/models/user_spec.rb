require 'rails_helper'

RSpec.describe User, type: :model do
  example_user = User.new(name: 'Carlos',
                          photo: 'url',
                          bio: 'The Bio from Carlos',
                          posts_counter: 0)

  before(:all) { example_user.save }

  describe 'validate data: ' do
    it 'not valid if name is empty' do
      example_user.name = ''
      expect(example_user).to_not be_valid
    end

    it 'posts_counter is not valid if it is lower than zero or not an integer' do
      example_user.name = 'John'
      example_user.posts_counter = -1
      expect(example_user).to_not be_valid
      example_user.posts_counter = 'test'
      expect(example_user).to_not be_valid
    end

    it 'posts_counter is valid if it is an integer equal to or greater than zero' do
      example_user.name = 'John'
      example_user.posts_counter = 0
      expect(example_user).to be_valid
      example_user.posts_counter = 99
      expect(example_user).to be_valid
    end
  end

  describe 'recent_posts method' do
    before do
      Post.create(author_id: example_user.id, title: 'example_title', text: 'one')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'two')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'three')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'four')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'five')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'six')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'seven')
      Post.create(author_id: example_user.id, title: 'example_title', text: 'eigth')
    end

    it 'should return three latest posts' do
      expect(example_user.recent_posts.length).to eq(3)
      expect(example_user.recent_posts[0].text).to eq 'eigth'
    end
  end
end
