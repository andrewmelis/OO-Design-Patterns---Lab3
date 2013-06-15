require_relative 'authentication'

class UI
  attr_accessor :authenticator, :client

  def initialize
    @authenticator = Authenticator.new
    @client = @authenticator.client
  end

  def main_loop
    cmd = 0
    while cmd != 5
      show_options
      cmd = get_cmd

      if cmd == 1
        input_search_song
      end
    end
  end

  def show_options
      puts "\n\n\n\n\n"
      puts "To get a recommendation for a track, input 1 and hit enter"

      puts "\nOr,to exit, input 5 and hit enter"
    end

  def get_cmd
    input = gets.chomp
    puts "you entered #{input}"
    return input.to_i
  end

  #returns input command as integer
  def get_input
    input = gets.chomp
    puts "you entered #{input}"
    return input
  end

  def input_search_song
    puts "enter an artist and a track, comma separated"
    puts "like this: the beatles, get back"
    arr = get_input.split(', ')
    artist = arr[0]
    track = arr[1]

    puts "\n\n\n"
    puts "retrieving recommendation, please wait..."
    puts "\n\n\n"

    #returns an array of hashes
    all_similar = @client.track.get_similar(:artist => artist, :track => track)

    rec = all_similar.first

    puts "check out #{rec['name']} by #{rec['artist']['name']}."
    puts "listen at #{rec['url']}"
  end

end

# ui = UI.new
# ui.main_loop