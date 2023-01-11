require 'rails_helper'

RSpec.describe 'the Sessions create' do 
  before(:each) do 
    @user_data = File.read('spec/fixtures/strava_athlete.json')
    stub_request(:post, 'https://www.strava.com/api/v3/oauth/token')
      .with(query: hash_including({}))
      .to_return(status: 200, body: @user_data)
    
    @json = File.read('spec/fixtures/user_data.json')
    @json2 = File.read('spec/fixtures/user_activities.json')
    stub_request(:get, 'http://localhost:3000/api/v1/user?')
      .to_return(status: 200, body: @json)
    stub_request(:get, 'http://localhost:3000/api/v1/activities?')
      .to_return(status: 200, body: @json2)
  end

  context 'successful login' do 
    it 'creates a new user if user doesnt exist' do 
      visit exchange_token_path(scope: "read,activity:read_all", code: 'foken') 
      
      new_user = User.last
      expect(new_user.strava_uid).to eq(8040180)
    end

    it 'updates existing user if user already exists' do 
      create(:user, strava_uid: 8040180, firstname: 'Not Ashley', lastname: 'Not Turner')
      visit exchange_token_path(scope: "read,activity:read_all", code: 'foken') 

      existing_user = User.find_by(strava_uid: 8040180)
      
      expect(existing_user.firstname).to eq('Ashley')
      expect(existing_user.lastname).to eq('Turner')
    end
  end

  context 'sad paths' do 
    it 'redirects to login if wrong scopes given' do 
      visit exchange_token_path(scope: "read", code: 'foken')

      expect(current_path).to eq('/')
    end
  end
end