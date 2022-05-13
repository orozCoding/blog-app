# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Comments API' do

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    # parameter name: 'Authorization', in: :header, type: :string
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'
    
    get 'Shows comments in user\'s post' do
      tags 'Comments'
      produces 'application/json'
      
      response '201', 'User post found' do
        schema type: :object,
        properties: {
          comment_id: { type: :integer },
          author_id: { type: :integer },
          post_id: { type: :integer },
          text: {type: :string}
        },
        required: ['author_id:', 'post_id', 'text']
        
        let(:user_id) { '1' }
        let(:post_id) { '1' }
        run_test!
      end
    end
    
    post 'Create comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :text, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Comment created' do
        schema type: :object,
        properties: {
          comment_id: { type: :integer },
          author_id: { type: :integer },
          post_id: { type: :integer },
          text: {type: :string}
        },
        required: ['author_id:', 'post_id', 'text']

        let(:user_id) { '1' }
        let(:post_id) { '1' }
        run_test!
      end
    end
  end
end
