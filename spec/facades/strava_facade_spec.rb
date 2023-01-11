require 'rails_helper'

RSpec.describe StravaFacade do 
  before(:each) do 
    @user_data = File.read('spec/fixtures/strava_athlete.json')
    stub_request(:post, 'https://www.strava.com/api/v3/oauth/token')
      .with(query: hash_including({}))
      .to_return(status: 200, body: @user_data)
  end

  it 'returns a strava athlete object' do 
    athlete = StravaFacade.get_athlete('authorization code')

    expect(athlete.firstname).to be_a String
    expect(athlete.lastname).to be_a String
    expect(athlete.photo_url).to be_a String
    expect(athlete.access_token).to be_a String
    expect(athlete.strava_uid).to be_a Integer
  end
end