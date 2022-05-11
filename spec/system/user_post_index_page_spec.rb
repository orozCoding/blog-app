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
      post2 = Post.create(id: 2, author: @user1, title: 'Test2', text: 'This is how I do it')
      Post.create(id: 3, author: @user1, title: 'Test3', text: 'Of course')
      Post.create(id: 4, author: @user1, title: 'Test4', text: 'Another post!')

      Comment.create(author_id: @user1.id, post_id: post2.id, text: 'very nice')
    end

    it "shows user's profile picture, name and number of posts" do
      visit user_posts_path(@user1)
      expect(page).to have_css('img[src*=photo1]')
      expect(page).to have_content('Angel')
      expect(page).to have_content('Number of posts: 4')
    end

    it "shows a post's title, body, first comments, how many comments and likes it has" do
      visit user_posts_path(@user1)
      expect(page).to have_content('Post #2')
      expect(page).to have_content('This is')
      expect(page).to have_content('Recent comments')
      expect(page).to have_content('very nice')
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 0')
    end

    it "redirects to a post if a click on it's title" do
      visit user_posts_path(@user1)
      click_link('Post #2')
      expect(page).to have_content('Post #2 by')
    end
  end
end
