class BrucycleService
  def self.get_user(strava_id)
    response = conn.get("api/v1/users?uid=#{strava_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://localhost:3000/')
  end
end

# {:data=>
#   {:id=>"62",
#    :type=>"user",
#    :attributes=>
#     {:username=>"Kay Mart",
#      :beers_drunk=>14,
#      :brubank=>866.04,
#      :tot_gas_money_saved=>7.5,
#      :tot_calories_burned=>7.5,
#      :tot_miles_biked=>0.00375}}}

# api/v1/user?uid=STRAVA_UID