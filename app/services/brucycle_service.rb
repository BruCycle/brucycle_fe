class BrucycleService
  def self.get_user(strava_uid, token)
    response = conn.get("/api/v1/user") do |req|
      req.headers['STRAVA_UID'] = strava_uid.to_s
      req.headers['STRAVA_TOKEN'] = token
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.drink_beer(strava_uid)
    conn.patch("api/v1/user?drank=beer") do |req|
      req.headers['STRAVA_UID'] = strava_uid.to_s
    end
  end

  def self.gift_beer(strava_uid, recipient_uid)
    conn.patch('/api/v1/user?gift=beer') do |req|
      req.headers['STRAVA_UID'] = strava_uid.to_s
      req.headers['RECIPIENT_UID'] = recipient_uid.to_s
    end
  end

  def self.get_activities(strava_uid, token)
    response = conn.get("api/v1/activities") do |req|
      req.headers['STRAVA_UID'] = strava_uid.to_s
      req.headers['STRAVA_TOKEN'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
 
  def self.conn
    Faraday.new(url: ENV['be_base_url'])
  end
end