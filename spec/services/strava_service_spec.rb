require 'rails_helper'

RSpec.describe StravaService do 
  describe 'class methods' do
    describe '.conn' do 
      it 'connects with strava api' do 
        conn = StravaService.conn

        expect(conn).to be_a Faraday::Connection
        expect(conn.url_prefix).to be_a URI::HTTPS
      end
    end

    describe '.get_athlete_data' do 
      it 'gets athlete data and access token' do 
        VCR.use_cassette('strava_auth_code') do 
          code = '22330ec32fd0a86e6fa946b64389fc6b32333dd3'
          @data = StravaService.get_athlete_data(code)
        end
        
        expect(@data).to have_key(:access_token)

        expect(@data[:athlete]).to have_key(:id)
        expect(@data[:athlete]).to have_key(:firstname)
        expect(@data[:athlete]).to have_key(:lastname)
        expect(@data[:athlete]).to have_key(:profile)
      end
    end
  end
end