require 'rails_helper'

RSpec.describe 'the Sessions create' do 
  before(:each) do 
    @user_data = {:token_type=>"Bearer",
      :expires_at=>1673302659,
      :expires_in=>3685,
      :refresh_token=>"c2195164da28f69d67613d8e4db35477363ec9a2",
      :access_token=>"2a870a9fd1d600079ec9852f68bbb7b7a0c84a76",
      :athlete=>
       {:id=>8040180,
        :username=>nil,
        :resource_state=>2,
        :firstname=>"Ashley",
        :lastname=>"Turner",
        :bio=>"",
        :city=>"Denver",
        :state=>"Colorado",
        :country=>"United States",
        :sex=>"F",
        :premium=>false,
        :summit=>false,
        :created_at=>"2015-02-25T00:23:28Z",
        :updated_at=>"2023-01-07T21:39:28Z",
        :badge_type_id=>0,
        :weight=>86.1825,
        :profile_medium=>"https://dgalywyr863hv.cloudfront.net/pictures/athletes/8040180/26271026/1/medium.jpg",
        :profile=>"https://dgalywyr863hv.cloudfront.net/pictures/athletes/8040180/26271026/1/large.jpg",
        :friend=>nil,
        :follower=>nil}}

    
    
    allow(StravaService).to receive(:get_athlete_data).and_return(@user_data)
    
    @json = File.read('spec/fixtures/user_data.json')
    @json2 = File.read('spec/fixtures/user_activities.json')
    stub_request(:get, 'http://localhost:3000/api/v1/user?')
      .to_return(status: 200, body: @json)
    stub_request(:get, 'http://localhost:3000/api/v1/activities?')
      .to_return(status: 200, body: @json2)
  end

  context 'successful login' do 
    it 'creates a new user if user doesnt exist' do 
      visit exchange_token_path(scope: "read,activity:read_all", code: 'foken') 

      new_user = User.last
      expect(new_user.strava_uid).to eq(8040180)
    end
  end

  context 'sad paths' do 
    it 'redirects to login if wrong scopes given' do 
      visit exchange_token_path(scope: "read", code: 'foken')

      expect(current_path).to eq('/')
    end
  end
end