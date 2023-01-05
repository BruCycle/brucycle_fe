class UserFacade
  def self.user(strava_id)
    UserService.get_user(strava_id)[:data][:attributes] do |user_data|
      User.new(user_data)
    end
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