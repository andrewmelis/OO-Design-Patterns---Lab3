

class Blackboard
    #singleton?

    attr_accessor :solutions, :control_data

    def initialize
      @solutions = Array.new
      @control_data = Array.new
    end

    #control_data[0][0] = Authenitcator
    #control_date[0][1] = Input artist + track

    #shows control data and solutions to knowledge sources
    def inspect
      return @control_data, @solutions
    end

    def update

    end

    def conclusion
      # freq = @solutions.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      # rec = @solutions.sort_by { |v| freq[v] }.last
      rec = solutions[0]
      #gets most commonly recommended song
      puts "\n\n\ntry this one: #{rec['name']} by #{rec['artist']['name']}"
    end

  end
