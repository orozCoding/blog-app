require 'rspec'
RSpec.describe 'login page', type: :feature do
  describe 'Login' do
    before(:each) do
      User.create! name: 'jones', password: 'gilles', email: 'banlonjones@gmail.com', confirmed_at: Time.now
    end

    it 'show  ' do

    end
    after do
      # Do nothing
    end

    context 'when condition' do
      it 'succeeds' do
        pending 'Not implemented'
      end
    end
  end

end
