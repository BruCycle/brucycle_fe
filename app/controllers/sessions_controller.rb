class SessionsController < ApplicationController
  def create
    client_id = ENV['strava_client_id']
    client_secret = ENV['strava_client_secret']
    code = params[:code]

    conn = Faraday.new(url: 'https://www.strava.com', headers: {'Accept': 'application/json'})

    response = conn.post('/api/v3/oauth/token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
    end
    
    data = JSON.parse(response.body, symbolize_names: true)
    
    user = User.find_or_create_by(strava_id:data[:athlete][:id])
    user.update(username:data[:athlete][:username], firstname:data[:athlete][:firstname], lastname:data[:athlete][:lastname], photo_url:data[:athlete][:profile])
    session[:user_id] = user.id
    session[:token] = data[:refresh_token]
    redirect_to '/dashboard'
  end
end