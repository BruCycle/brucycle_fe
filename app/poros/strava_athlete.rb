class StravaAthlete
  attr_reader :strava_uid, :photo_url, :firstname, :lastname, :username, :access_token

  def initialize(data)
    @strava_uid = data[:athlete][:id]
    @photo_url = data[:athlete][:profile]
    @firstname = data[:athlete][:firstname]
    @lastname = data[:athlete][:lastname]
    @username = data[:athlete][:username]
    @access_token = data[:access_token]
  end

  def athlete_info
    {
      photo_url: @photo_url,
      firstname: @firstname,
      lastname: @lastname
    }
  end
end