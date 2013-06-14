#ABSTRACT knowledge_source class

class KnowledgeSource
  
  attr_acessor :recommendations, :rejections, :priority

  def initialize
    @recommendations = Array.new
    @rejections = Array.new
  end


  def exec_condition
    raise "can't call method on abstract class"
  end

  def excec_action
    raise "can't call method on abstract class"
  end

  def update_blackboard
    raise "can't call method on abstract class"
  end


end

class SimilarTrack < KnowledgeSource

  def initialize(artist, trackname)
    super initialize
    retrieve_similar(artist,trackname)  #get data on init?
  end

  def exec_condition(blackboard)
    #if blackboard has no client, have nothing to add
    if blackboard.inspect[0].class != Authenticator
      return false
    else
      temp = @recommendations - blackboard.inspect[1]
      @rejections = @recommendations - temp
      @recommendations = temp
      if @recommendations.empty?
        return false
      else
        return true
      end
    end
  end

  def exec_action
    update_blackboard
  end

  def update(blackboard)
    blackboard.@solutions = blackboard.@solutions & @recommendations
  end

  def retrieve_similar (artist, trackname)
    #returns an array of hashes
    #store only the first 5, for speed
    @recommendations = @client.track.get_similar(:artist => artist, :track => trackname).slice(0..5)
  end

end

#user input is really a knowledge source
class User < KnowledgeSource

  def initialize
    get_seed_data
  end

  #seed data is actually part of assumptions / control data ?
  def get_seed_data
    puts "enter an artist and a track, comma separated"
    puts "like this: the beatles, get back"

    puts "\n\n\n"
    puts "retrieving recommendation, please wait..."
    puts "\n\n\n"

    artist,trackname = get_input.split(', ')

    return artist, trackname  #return multiple values, as array
  end

    #returns input command as integer
  def get_input
    input = gets.chomp
    puts "you entered #{input}"
    return input
  end

end