require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
      expect(response.body).to include('Most recent posts:')
    end
  end
end
