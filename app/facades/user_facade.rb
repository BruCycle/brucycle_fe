class UserFacade
  def self.user(strava_id, token)
    user_data = BrucycleService.get_user(strava_id, token)[:data][:attributes]

    UserStats.new(user_data)
  end

  def self.get_activities(strava_id, token)
    activities = BrucycleService.get_activities(strava_id, token)

    activities[:data].map do |activity|
      Activity.new(activity[:attributes])
    end
  end

  def self.drink_beer(strava_id)
    BrucycleService.drink_beer(strava_id)
  end
end