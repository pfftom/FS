require "oauth_util"
require "net/http"
require "rexml/document"

class DataImport
  def initialize
    @auth = set_oauth
  end

  def get_data(url)
    parsed_url = URI.parse(url)
    Net::HTTP.start(parsed_url.host) do |http|
      request = Net::HTTP::Get.new "#{ parsed_url.path }?#{ @auth.sign(parsed_url).query_string }"
      REXML::Document.new(http.request(request).body)
    end
  end

  private

  def set_oauth
    auth = OauthUtil.new
    auth.consumer_key = ENV.fetch("YAHOO_KEY")
    auth.consumer_secret = ENV.fetch("YAHOO_SECRET")
    auth
  end
end
