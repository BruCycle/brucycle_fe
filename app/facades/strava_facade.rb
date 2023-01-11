class StravaFacade
  def self.get_athlete(auth_code)
    data = StravaService.get_athlete_data(auth_code)
    StravaAthlete.new(data)
  end
end