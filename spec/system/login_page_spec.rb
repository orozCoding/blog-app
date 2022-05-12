require 'rails_helper'

RSpec.describe 'Login Page', type: :system do
  before(:all) do
    driven_by(:rack_test)
  end

  describe 'login experience' do
    it 'shows the username and password inputs, and the Submit button' do
      visit new_user_session_path
      sleep(5)
      expect(page).to have_content('Log in')
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_button('LOG IN')
    end

    it 'shows detailed error when click LOG IN without filling the username and password' do
      visit new_user_session_path
      click_button 'LOG IN'
      expect(page).to have_content 'Invalid Email or password.'
    end

    it 'shows detailed error when enter invalid input to login' do
      visit new_user_session_path
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: '123456'
      click_button 'LOG IN'
      expect(page).to have_content 'Invalid Email or password.'
    end

    before do
      User.destroy_all
      User.delete_all

      user = User.create(username: 'angel', email: 'loco@loco.com', name: 'Angel', password: 'password',
                         password_confirmation: 'password')
      user.confirm
    end

    it 'logs in with correct data' do
      visit new_user_session_path
      fill_in 'Email', with: 'loco@loco.com'
      fill_in 'Password', with: 'password'
      click_button 'LOG IN'
      sleep(5)
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
