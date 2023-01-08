class BrucycleService
  def self.get_user(strava_id, token)
    response = conn.get("/api/v1/user") do |req|
      req.headers['STRAVA_UID'] = strava_id.to_s
      req.headers['STRAVA_TOKEN'] = token
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.drink_beer(strava_id)
    conn.patch("api/v1/user?drank=beer") do |req|
      req.headers['STRAVA_UID'] = strava_id.to_s
    end
  end

  def self.get_activities(strava_id, token)
    response = conn.get("api/v1/activities") do |req|
      req.headers['STRAVA_UID'] = strava_id.to_s
      req.headers['STRAVA_TOKEN'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
 
  def self.conn
    Faraday.new(url: ENV['be_base_url'])
  end
end