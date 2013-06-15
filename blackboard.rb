

class Blackboard

    attr_accessor :solutions, :control_data, :rejections

    def initialize
      @solutions = Array.new
      @control_data = Array.new
      @rejections = Array.new
    end

    #control_data[0][0] = Authenitcator
    #control_date[0][1] = Input artist + track

    #shows control data and solutions to knowledge sources
    def inspect
      return @control_data, @solutions
    end

    def update
      #stuff
    end

    def conclusion
      rec = solutions[0]
      #gets most commonly recommended song
      puts "\n\n\ntry this one: #{rec['name']} by #{rec['artist']['name']}"
      puts "type no and hit enter if you'd like another recommendation"
      return rec
    end

    def rejection(rec)
      @rejections<<(rec)
      @solutions.keep_if{|i| i!=rec}
    end


  end
