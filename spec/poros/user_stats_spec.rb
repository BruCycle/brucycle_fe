require 'rails_helper'

RSpec.describe UserStats do 
  before(:each) do 
    data = {:username=>"Kay Mart", :beers_drunk=>14, :brubank=>866.04, :tot_gas_money_saved=>7.5, :tot_calories_burned=>7.5, :tot_miles_biked=>0.00375}
    @user_stats = UserStats.new(data)
  end

  it 'exists and has attributes' do 
    expect(@user_stats).to be_a UserStats

    expect(@user_stats.username).to eq('Kay Mart')
    expect(@user_stats.beers_drunk).to eq(14)
    expect(@user_stats.brubank).to eq(866.04)
    expect(@user_stats.tot_gas_money_saved).to eq(7.5)
    expect(@user_stats.tot_calories_burned).to eq(7.5)
    expect(@user_stats.tot_miles_biked).to eq(0.00375)
  end
end