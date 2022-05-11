require 'rails_helper'

RSpec.describe 'Index Page', type: :system do
  before(:all) do
    driven_by(:rack_test)
  end

  describe 'visiting index page' do
    before do
      User.destroy_all
      User.delete_all

      user1 = User.create(username: 'angel', photo: 'photo1', email: 'loco@loco.com', name: 'Angel', password: 'password',
                          password_confirmation: 'password')
      user1.confirm

      user2 = User.create(username: 'jones', photo: 'photo2', email: 'jones@jones.com', name: 'Jones', password: 'password',
                          password_confirmation: 'password')
      user2.confirm

      Post.create(author: user1, title: 'Test', text: 'Testing a lot')
    end


    it 'shows the names of each user' do
      visit users_path
      sleep(5)
      expect(page).to have_content('Angel')
      expect(page).to have_content('Jones')
    end

    it 'shows the photos of each user' do
      visit users_path
      expect(page).to have_css("img[src*=photo1]")
      expect(page).to have_css("img[src*=photo2]")
    end

    it 'shows the photos of each user' do
      visit users_path
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 0')
    end

    it 'shows user profile when clicking name' do
      visit users_path
      find_link('Angel').click
      sleep(3)
      expect(page).to have_content('bio:')
    end
  end
end