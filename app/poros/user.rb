class User
  attr_reader :username, :beers_drunk, :brubank, :tot_gas_money_saved, :tot_calories_burned, :tot_miles_biked
  
  def initialize(data)
    @username = data[:username]
    @beers_drunk = data[:beers_drunk]
    @brubank = data[:brubank]
    @tot_gas_money_saved = data[:tot_gas_money_saved]
    @tot_calories_burned = data[:tot_calories_burned]
    @tot_miles_biked = data[:tot_miles_biked]
  end
end