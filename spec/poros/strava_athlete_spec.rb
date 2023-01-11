require 'rails_helper'

RSpec.describe StravaAthlete do 
  before(:each) do 
    data = File.read('spec/fixtures/strava_athlete.json')
    hash = JSON.parse(data, symbolize_names: true)
    @athlete = StravaAthlete.new(hash)
  end

  describe '#initialize' do 
    it 'has attributes' do 
      expect(@athlete.firstname).to be_a String
      expect(@athlete.lastname).to be_a String
      expect(@athlete.photo_url).to be_a String
      expect(@athlete.access_token).to be_a String
      expect(@athlete.strava_uid).to be_a Integer
    end
  end

  describe '#athlete_info' do 
    it 'returns a hash of specific athlete info' do 
      expect(@athlete.athlete_info).to have_key(:photo_url)
      expect(@athlete.athlete_info).to have_key(:firstname)
      expect(@athlete.athlete_info).to have_key(:lastname)

      expect(@athlete.athlete_info[:photo_url]).to eq(@athlete.photo_url)
      expect(@athlete.athlete_info[:lastname]).to eq(@athlete.lastname)
      expect(@athlete.athlete_info[:firstname]).to eq(@athlete.firstname)
    end
  end
end