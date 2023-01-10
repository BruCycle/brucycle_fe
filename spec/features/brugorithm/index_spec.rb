require 'rails_helper'

RSpec.describe 'brugorithm page' do 
  before :each do
    @json = File.read('spec/fixtures/user_data.json')
    @json2 = File.read('spec/fixtures/user_activities.json')
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(@user)
        
    stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)

    stub_request(:get, 'http://localhost:3000/api/v1/activities?')
        .to_return(status: 200, body: @json2)
        
    visit '/brugorithm'
  end
  describe 'contents' do 
    it 'displays the brugorithm to the user' do 
      expect(page).to have_content("Brügorithm")
      expect(page).to have_content("Beers Banked From Money Saved")
      expect(page).to have_content("Beers Banked From Calories Burned")
      expect(page).to have_content("Total Beers Banked")
    end

    it 'will have link back to dashboard' do 
      expect(page).to have_link("Dashboard")

      click_link "Dashboard"

      expect(current_path).to eq("/dashboard")
    end
  end
end