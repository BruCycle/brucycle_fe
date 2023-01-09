class StravaService
  def self.get_athlete_data(code)
    response = conn.post('/api/v3/oauth/token') do |req|
      req.params['code'] = code
      req.params['client_id'] = ENV['strava_client_id']
      req.params['client_secret'] = ENV['strava_client_secret']
      req.params['grant_type'] = 'authorization_code'
    end

    JSON.parse(response.body, symbolize_names: true)
  end


  def self.conn
    Faraday.new(url: 'https://www.strava.com', headers: { 'Accept': 'application/json' })
  end
end