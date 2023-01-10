require 'rails_helper'

RSpec.describe 'the Login page' do
  describe 'it has attributes' do
    it 'has app name and link to OAuth' do
      visit '/'

      expect(page).to have_content('BrüCycle')
      expect(page).to have_content('Burn it to earn it')
      expect(page).to have_link('Login with Strava',
                                href: "http://www.strava.com/oauth/authorize?client_id=#{ENV['strava_client_id']}&response_type=code&redirect_uri=http://www.example.com/exchange_token&approval_prompt=force&scope=read,activity:read_all")
    end
  end

  context 'succesfully logging in' do
    it 'creates a new user if the user hasnt logged in before' do 
      allow(StravaService).to receive(:get_athlete_data).and_return(@user_data)
    end
  end

  context 'user already logged in' do 
    before(:each) do 
      @json = File.read('spec/fixtures/user_data.json')
      @json2 = File.read('spec/fixtures/user_activities.json')
      @user = create(:user)

      stub_request(:get, 'http://localhost:3000/api/v1/user?')
        .to_return(status: 200, body: @json)

      stub_request(:get, 'http://localhost:3000/api/v1/activities?')
        .to_return(status: 200, body: @json2)

      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(@user)

        visit '/'
    end

    it 'has a button to logout' do 
      session = { user_id: @user.id, token: '1234567890'}
      allow_any_instance_of(ApplicationController).to receive(:session)
        .and_return(session)

      click_link 'Logout'

      expect(current_path).to eq('/')
      expect(page).to have_content('You have been successfully logged out')
    end

    it 'has a button that redirects to the users dashboard' do 
      click_link 'Go to Dashboard'

      expect(current_path).to eq('/dashboard')
    end
  end

  context 'sad paths' do
  end
end
