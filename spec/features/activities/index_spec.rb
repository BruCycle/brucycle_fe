require 'rails_helper'

RSpec.describe 'the Activities index' do 
  describe 'as a user when i visit the activity page' do 
    before(:each) do 
      @json = File.read('spec/fixtures/user_data.json')
      @user = create(:user)

      stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(@user)

      visit '/activities'
    end

    it 'i see all my activites listed' do 
      expect(page).to have_content("#{@user.firstname}'s Activities")
      expect(page).to have_content('Date')
      expect(page).to have_content('Title')
      expect(page).to have_content('Miles')
      expect(page).to have_content('Calories Burned')
      expect(page).to have_content('Gas $ Saved')
      expect(page).to have_content('Beers Banked')
    end
  end
end

# As a user,
# when I visit my activity page,
# I want to see all my activities listed out,
# with date, title, miles, calories burned, gas $ saved, and beers banked.


