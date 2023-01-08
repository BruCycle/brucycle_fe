class SessionsController < ApplicationController
  def create
    client_id = ENV['strava_client_id']
    client_secret = ENV['strava_client_secret']
    code = params[:code]

    conn = Faraday.new(url: 'https://www.strava.com', headers: { 'Accept': 'application/json' })

    response = conn.post('/api/v3/oauth/token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
    end

    data = JSON.parse(response.body, symbolize_names: true)

    user = User.find_or_create_by(strava_id: data[:athlete][:id])
    user.update(photo_url: data[:athlete][:profile],
                firstname: data[:athlete][:firstname],
                lastname: data[:athlete][:lastname])

    user.update(username: data[:athlete][:username]) if user.username.nil?

    session[:user_id] = user.id
    session[:token] = data[:access_token]
    redirect_to '/dashboard'
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)
    flash[:alert] = 'You have been successfully logged out'

    redirect_to '/'
  end
end
