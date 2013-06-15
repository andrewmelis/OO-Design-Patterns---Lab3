#ABSTRACT knowledge_source class

class KnowledgeSource

  attr_accessor :recommendations, :rejections, :priority, :controller, :canConnect

  def initialize(controller)
    @recommendations = Array.new
    @rejections = Array.new
    @controller = controller
    @canConnect = false;
    controller.knowledge_sources<<(self)
    controller.blackboard.control_data[0].references<<(self)
    controller.blackboard.control_data[0].notify(true)

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

  # def initialize(controller)
  #   super(controller)

  # end

  def exec_condition()
    #if blackboard has no client, have nothing to add
    if canConnect==false
      return false
    else
      retrieve_similar()  #get data on init?
      if @recommendations.empty?
        return false
      else
        return true
      end
    end
  end

  def exec_action
    # update(@controller.blackboard)
  end

  def update(blackboard)
    #slice! deletes items in range from recommendnations, so no duplicates later
    blackboard.solutions = blackboard.solutions + @recommendations.slice!(0..5)
  end

  def retrieve_similar()
    puts "\n\n\n"
    puts "retrieving recommendation, please wait..."
    puts "\n\n\n"

    #blackboard.inspect[0][1] is inputs from user
    artist = @controller.blackboard.inspect[0][1][0]
    trackname = @controller.blackboard.inspect[0][1][1]

    #returns an array of hashes
    #inspect[0][0] returns control_data[0] = client

    @recommendations = @controller.blackboard.inspect[0][0].client.track.get_similar(:artist => artist, :track => trackname)
  end

end

class PlayCount < KnowledgeSource

  def exec_condition()
    #if blackboard has no client, have nothing to add
    if canConnect==false
      return false
    elsif @controller.blackboard.solutions.size==0
      return false
    else
      return true
    end
  end

  def exec_action
    retrieve_similar
    # update(@controller.blackboard)
  end

  def update(blackboard)
    #put an extra copy of this similar track in front
    blackboard.solutions.insert(0,@recommendations[0])
  end

  def retrieve_similar
    puts "\nretrieving song play counts, please wait..."

    


    #blackboard.inspect[0][1] is inputs from user
    artist = @controller.blackboard.inspect[0][1][0]
    trackname = @controller.blackboard.inspect[0][1][1]
    
    input = @controller.blackboard.inspect[0][0].client.track.get_info(:artist => artist, :track => trackname)
    input_count = input['playcount'].to_i

    most_similar_diff = 999999999
    most_similar_track = input

    @controller.blackboard.solutions.each do |s|

      cur = @controller.blackboard.inspect[0][0].client.track.get_info(:artist => s['artist']['name'], :track => s['name'])
      cur_count = cur['playcount'].to_i

      diff = (input_count - cur_count).abs
      
      if(diff < most_similar_diff)
        most_similar_track = cur
        most_similar_diff = diff
      end

    end

    @recommendations<<(most_similar_track)
    
  end

end


class  SimilarArtists < KnowledgeSource
  def exec_condition()
    #if blackboard has no client, have nothing to add
    if canConnect==false
      return false
    else
      retrieve_similar()  #get data on init?
      if @recommendations.empty?
        return false
      else
        return true
      end
    end
  end

  def exec_action
    # update(@controller.blackboard)
  end

  def update(blackboard)
    #slice! deletes items in range from recommendnations, so no duplicates later
    blackboard.solutions = blackboard.solutions + @recommendations
  end

  def retrieve_similar()
    puts "\nretrieving similar artists, please wait..."

    #blackboard.inspect[0][1] is inputs from user
    artist = @controller.blackboard.inspect[0][1][0]

    similar_artists = @controller.blackboard.inspect[0][0].client.artist.get_similar(:artist => artist)
    similar_artists = similar_artists[1..3]
    similar_artists.each do |a|
      artist_top = @controller.blackboard.inspect[0][0].client.artist.get_top_tracks(:artist => a['name'])
      @recommendations<<(artist_top.first)
    end
  end

end


#user input is really a knowledge source
class User < KnowledgeSource

  attr_accessor :inputs

  # def initialize(controller)
  #   super(controller)
  #   controller.knowledge_sources<<(self)
  # end

  def exec_condition
    if canConnect==false
      return false
    elsif @controller.blackboard.control_data.size==1
      return true
    else
      return false
    end

  end

  def exec_action
    get_seed_data
  end

  def update(blackboard)
    blackboard.inspect[0]<<(inputs)
  end


  #seed data is actually part of assumptions / control data ?
  def get_seed_data
    puts "enter an artist and a track, comma separated"
    puts "like this: the beatles, get back"

    @inputs = get_input.split(', ')
  end

  #returns input command as integer
  def get_input
    input = gets.chomp
    puts "you entered #{input}"
    return input
  end

end
