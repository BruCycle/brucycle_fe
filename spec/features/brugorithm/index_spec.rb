require 'rails_helper'

RSpec.describe 'brugorithm page' do 
  before :each do 
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