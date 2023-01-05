# require './app/services/brucycle_service'

class UserFacade
  def self.user(strava_id)
    user_data= BrucycleService.get_user(strava_id)[:data][:attributes]
    
    UserStats.new(user_data)
  end
end