require 'rails_helper'

RSpec.describe 'the User Dashboard page' do 
#   As a user,
#   when I visit my dashboard page,
#   I want to see my Brübank with a button to delete a beer,
#   I want to see my Lifetime Stats, including Gas Money Saved, Calories Burned, Beers Consumed, and Distance Biked

  describe 'page has attributes' do 
    it 'has lifetime stats and athlete data' do 
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Welcome, #{user.firstname}")
      expect(page).to have_content('Lifetime Stats')
      expect(page).to have_content('Gas Money Saved')
      expect(page).to have_content('Calories Burned')
      expect(page).to have_content('Beers Consumed')
      expect(page).to have_content('Distance Biked')

      expect(page).to have_link('I Drank a Beer')
      expect(page).to have_content('BrüBank')
    end
  end


  # As a user,
  # when I visit my dashboard page,
  # I want to see a button that takes me to my activities,
  # so that I can see all my activities. When I click this button, I am directed to my activities page. 
end