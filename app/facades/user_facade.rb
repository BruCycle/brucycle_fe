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
end

# {:data=>
#   [{:id=>nil,
#     :type=>“activity”,
#     :attributes=>
#      {:date=>“2023-01-04T21:20:44.000Z”,
#       :title=>“Afternoon Run”,
#       :miles=>0.023125,
#       :calories_burned=>1.15,
#       :gas_money_saved=>0.0029,
#       :beers_banked=>0.0007}},
#    {:id=>nil,