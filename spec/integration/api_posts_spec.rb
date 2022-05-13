# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Posts API' do

  path '/api/v1/users/{user_id}/posts' do
    # parameter name: 'Authorization', in: :header, type: :string
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get 'Shows posts from user' do
      tags 'Posts'
      produces 'application/json'

      response '201', 'User posts found' do
        schema type: :object,
        properties: {
          post_id: { type: :integer },
          author_id: { type: :integer },
          title: {type: :string},
          text: {type: :string}
        },
        required: ['post_id', 'title', 'text']

        let(:user_id) { '1' }
        run_test!
      end
    end
  end
end
