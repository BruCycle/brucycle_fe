require 'rails_helper'

RSpec.describe 'the User Dashboard page' do
  describe 'page has attributes' do
    before(:each) do
      @json = File.read('spec/fixtures/user_data.json')
      @user = create(:user)

      stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)

      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(@user)
    end

    it 'has lifetime stats and athlete data' do
      visit '/dashboard'

      expect(page).to have_content("Welcome, #{@user.firstname}")
      expect(page).to have_content('Lifetime Stats')
      expect(page).to have_content('Gas Money Saved: $7.50')
      expect(page).to have_content('Calories Burned: 7.5')
      expect(page).to have_content('Beers Consumed: 14')
      expect(page).to have_content('Distance Biked: 0.00375')

      expect(page).to have_link('I Drank a Beer')
      expect(page).to have_content('BrüBank: 866.04')
    end

    it 'redirects user to dashboard after consuming and clicking drink_beer button' do
      visit '/dashboard'
      stub_request(:patch, 'http://localhost:3000/api/v1/user?drank=beer')
        .to_return(status: 204)

      click_link 'I Drank a Beer'

      expect(current_path).to eq('/dashboard')
    end

    it 'has a button to redirect to activities' do
      visit '/dashboard'

      json = File.read('spec/fixtures/user_activities.json')
      stub_request(:get, 'http://localhost:3000/api/v1/activities?')
        .to_return(status: 200, body: json)

      click_link 'View All Activities'

      expect(current_path).to eq('/activities')
    end

    describe 'as a user i can edit my username' do
      it 'has a button to edit username' do
        visit '/dashboard'

        expect(page).to have_link('Edit Username')

        click_link "Edit Username"

        expect(current_path).to eq("/user/edit")
      end
    end

    describe 'as a user i can logout' do 
      it 'has a button to logout' do
        visit '/dashboard'

        session = { user_id: @user.id, token: '1234567890'}
        allow_any_instance_of(ApplicationController).to receive(:session)
          .and_return(session)

        expect(page).to have_link('Logout')

        click_link 'Logout'

        expect(current_path).to eq('/')
        expect(page).to have_content('You have been successfully logged out')
      end
    end
  end
end
