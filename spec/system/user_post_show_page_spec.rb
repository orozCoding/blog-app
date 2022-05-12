require 'rails_helper'

RSpec.describe 'User post show page', type: :system do
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

      @post2 = Post.create(id: 2, author: @user1, title: 'Test2', text: 'This is how I do it')

      Comment.create(author_id: @user1.id, post_id: @post2.id, text: 'very nice')
    end

    it "shows the post's title, author, body, how many comments and likes it has" do
      visit user_post_path(@user1, @post2)
      expect(page).to have_content('Post #2 by Angel')
      expect(page).to have_content('This is')
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 0')
    end

    it 'shows the username of each commentor and the comment' do
      visit user_post_path(@user1, @post2)
      expect(page).to have_content('Angel: very nice')
    end
  end
end
