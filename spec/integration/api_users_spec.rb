# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization Token'

    get 'Shows users' do
      tags 'User'
      produces 'application/json'

      response '201', 'Users list' do
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}' do
    parameter name: 'Authorization', in: :header, type: :string, description: 'Authorization Token'
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get 'Shows user info' do
      tags 'User'
      produces 'application/json'

      response '201', 'User found' do
        schema type: :object,
        properties: {
          user_id: { type: :integer  },
          name: {type: :string}
        },
        required: ['user_id', 'name']

        let(:user_id) { User.create(name: 'Angel').id }
        run_test!
      end
    end
  end
end
