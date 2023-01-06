class BrucycleService
  def self.get_user(strava_id)
    response = conn.get("api/v1/users?uid=#{strava_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://localhost:3000/')
  end
end