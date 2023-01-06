# require './app/services/brucycle_service'

class UserFacade
  def self.user(strava_id, token)
    user_data = BrucycleService.get_user(strava_id, token)[:data][:attributes]

    UserStats.new(user_data)
  end
end