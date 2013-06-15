#from https://github.com/youpy/ruby-lastfm
require 'lastfm'


#make this a blackboard object?
class Authenticator
  attr_reader :api_key, :secret_key 
  attr_accessor :client, :references

  def initialize(blackboard)
    @api_key = "5f376ba66130fc50ab78ff155b7430a7"
    @secret_key = "92b90e576e718e74bd2725a559ea4a71"
    @references = Array.new
    get_client
    get_new_token
    blackboard.control_data<<(self)
    # notify(true)
  end

  def get_client
    @client = Lastfm.new(@api_key,@secret_key)
    puts "lastfm client: #{@client}"
  end

  def get_new_token
    token = @client.auth.get_token
    # puts token
    token_url = "http://www.last.fm/api/auth/?api_key=#{@api_key}&token=#{token}"
    puts "token url, hit enter when authenticated:"
    puts "#{token_url}"
    gets
    @client.session = @client.auth.get_session(:token => token)['key']
    puts "session: #{@client.session}"
  end

  #dependent method
  def notify(client_status)
    references.each do |k|
      k.canConnect = client_status
    end
  end

end



