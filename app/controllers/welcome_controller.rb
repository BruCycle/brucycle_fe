class WelcomeController < ApplicationController
  def index
    @base_url = request.base_url
  end
end
