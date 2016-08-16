class HomeController < ApplicationController
  before_action :authenticate, only: [:phrases]

  def phrases
    response.headers["Authorization"] = @client.auth_token
    render plain: "OK"
  end

  private

  def authenticate
    authenticate_with_http_token do |token, options|
      @client = Client.find_by(auth_token: token)
      if (@client.blank? || @client.created_at < 5.minutes.ago)
        @client = Client.create
      else
        @client.touch
      end
    end
  end
end
