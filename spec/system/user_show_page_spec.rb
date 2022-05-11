require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  before(:all) do
    driven_by(:rack_test)
  end

  describe 'visiting user show page' do
    before(:all) do
      User.destroy_all
      @user1 = User.create(username: 'angel', photo: 'photo1', email: 'loco@loco.com', name: 'Angel', password: 'password',
                           password_confirmation: 'password')
      @user1.confirm

      Post.destroy_all

      Post.create(id: 1, author: @user1, title: 'Test', text: 'Testing a lot')
      Post.create(id: 2, author: @user1, title: 'Test2', text: 'This is how I do it')
      post3 = Post.create(id: 3, author: @user1, title: 'Test3', text: 'Of course')
      Post.create(id: 4, author: @user1, title: 'Test4', text: 'Another post!')

      Comment.create(author_id: @user1.id, post_id: post3.id, text: 'very nice')
    end

    it 'shows the photos of the user' do
      visit user_path(@user1)
      expect(page).to have_css('img[src*=photo1]')
    end

    it "shows user's name" do
      visit user_path(@user1)
      expect(page).to have_content('Angel')
    end

    it "shows user's number of posts" do
      visit user_path(@user1)
      expect(page).to have_content('Number of posts: 4')
    end

    it "shows user's bio" do
      visit user_path(@user1)
      expect(page).to have_content('bio:')
    end

    it 'shows recent posts' do
      visit user_path(@user1)
      expect(page).to have_content('Of course')
      expect(page).to have_content('This is')
      expect(page).to have_content('Another')
    end

    it "redirects me to that post's show page when I click a user's post" do
      visit user_path(@user1)
      click_link('Post #3')
      sleep(1)
      expect(page).to have_content('Post #3 by')
    end

    it "shows a button that lets me view all of user's posts" do
      visit user_path(@user1)
      expect(page).to have_link('See all posts')
      click_link('See all posts')
      sleep(1)
      expect(page).to have_content('Post #1')
      expect(page).to have_content('Post #2')
      expect(page).to have_content('Post #3')
      expect(page).to have_content('Post #4')
    end
  end
end
