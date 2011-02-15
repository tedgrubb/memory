class Facebook
  include HTTParty
  base_uri 'graph.facebook.com:443'
  format :json

  def initialize(token)
    self.class.default_params :access_token => token
  end

  def post(path, query = {})
    self.class.post(path, :query => query)
  end

  # HTTParty get is on the class, so let's call that one and wrap it up in some error handling.
  def get(path, query = {})
    begin
      response = self.class.get(path, :query => query)
      if response.parsed_response.key? "error"
        raise response.parsed_response["error"]["message"]
      else
        response["data"]
      end
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end
end
