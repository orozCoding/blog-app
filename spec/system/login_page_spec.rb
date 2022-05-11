require 'rails_helper'

RSpec.describe 'Hello world', type: :system do
  before(:all) do
    # Comment the line below this to see selinium open chrome browser
    driven_by(:rack_test)
  end
  
  describe 'index page' do
    it 'shows the right content' do
      visit users_path
      sleep(5)
      expect(page).to have_content('Active Users')
    end
  end
end