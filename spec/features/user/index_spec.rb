require 'rails_helper'

RSpec.describe 'the User Index page' do
  describe 'gift a beer to another user' do
    before do
      @json = File.read('spec/fixtures/user_data.json')
      @json2 = File.read('spec/fixtures/user_activities.json')

      @user = create(:user)
      create(:user, username: 'Yoshi')

      stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)

      stub_request(:get, 'http://localhost:3000/api/v1/activities?')
        .to_return(status: 200, body: @json2)
        
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/users'
    end
    it 'does not show my username in the list' do
      expect(page).to have_content('Yoshi')
      expect(page).to_not have_content(@user.username)
    end

    it 'can gift a beer' do
      stub_request(:patch, 'http://localhost:3000/api/v1/user?gift=beer')
        .to_return(status: 204)
      click_on '🍻'
      expect(current_path).to eq('/dashboard')
    end

    it 'flashes a message if user does not have enough beers' do
      stub_request(:patch, 'http://localhost:3000/api/v1/user?gift=beer')
        .to_return(status: 400)
      click_on '🍻'

      expect(current_path).to eq('/users')
      expect(page).to have_content('You don\'t have enough brüs')
    end
  end
end