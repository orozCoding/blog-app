require 'rails_helper'

RSpec.describe 'login page', type: :feature do
  describe 'Login' do
    before(:each) do
      User.create! username: 'jones', name: 'jones', password: 'gilles', email: 'banlon@gmail.com', confirmed_at: Time.now
    end

    describe 'login page' do
      it 'show username and password inputs and the "Submit" button' do
        visit new_user_session_path
        expect(page).to have_content('THE BLOG APP!')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Log in')
      end

      it 'wrong email and password' do
        visit new_user_session_path
        fill_in 'Email', with: 'Test@gmail.com'
        fill_in 'Password', with: '123456'
        sleep(1)
        click_button 'Log in'
        expect(page).to have_content('Log in')
      end

      it 'wrong email and password' do
        visit new_user_session_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        sleep(1)
        click_button 'Log in'
        expect(page).to have_content('Log in')
      end
    end
  end

end
