require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Using Users controller' do
    it 'gets users list' do
      get '/users/'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('This is a list of all users')
    end

    it 'shows user info' do
      get '/users/20'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Showing User info')
    end
  end
end
