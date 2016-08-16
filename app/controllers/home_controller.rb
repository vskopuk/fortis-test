class HomeController < ApplicationController
  before_action :authenticate, only: [:phrases]

  def phrases
    response.headers["Authorization"] = @client.auth_token
    phrase = Phrase.where.not("'#{@client.auth_token}' = ANY (clients)").limit(1).order("RANDOM()").first
    Phrase.where("text LIKE ?", "#{phrase.text}").update_all(["clients = array_append(clients, ?)", @client.auth_token])
    render plain: phrase.text
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
