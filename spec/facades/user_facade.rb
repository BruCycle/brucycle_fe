require 'rails_helper'

RSpec.describe UserFacade do 
  before(:each) do 
    @json = File.read('spec/fixtures/user_data.json')
    @user_id = 62
    stub_request(:get, "http://localhost:3000/api/v1/users?uid=#{@user_id}")
    .to_return(status: 200, body: @json)
  end 

  it 'creates a User object based on lifetime stats' do 
    user = UserFacade.user(@user_id)

    expect(user).to be_a UserStats

    expect(user.beers_drunk).to be_a Integer
    expect(user.brubank).to be_a Float
    expect(user.tot_calories_burned).to be_a Float
    expect(user.tot_gas_money_saved).to be_a Integer
    expect(user.tot_miles_biked).to be_a Integer
    expect(user.username).to be_a String
  end
end 