require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:example) do
    User.destroy_all
    Post.destroy_all
    user = User.create(id: 1, username: 'angel', email: '321@321.com', name: 'Angel', password: '321321',
                       password_confirmation: '321321')

    Post.destroy_all
    Post.create(id: 1, author: user, title: 'La vida', text: 'Es bella')
  end

  describe 'Using Posts controller' do
    it 'gets posts list from an user' do
      get '/users/1/posts'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Number of posts:')
    end

    it 'Show post info' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Post #')
    end
  end
end
