require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Using Users controller" do
    it "gets users list" do
      get "/users/"
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Find me in app/views/users/index.html.erb')
    end
  end
end
