require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:example) do
    User.destroy_all
    User.create(id: 1, username: 'angel', email: '321@321.com', name: 'Angel', password: '321321',
                password_confirmation: '321321')
  end

  it 'creates a new user' do
    expect(User.all.length).to be > 0
  end

  describe 'Using Users controller' do
    it 'gets users list' do
      get '/users/'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Active Users')
    end

    it 'shows user info' do
      get '/users/1'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Angel has no posts yet.')
    end
  end
end
