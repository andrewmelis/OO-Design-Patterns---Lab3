

class Blackboard
    #singleton?

    attr_accessor :solutions, :control_data

    def initialize
      @solutions = Array.new
      @control_data = Array.new
    end

    #shows control data and solutions to knowledge sources
    def inspect
      return @control_data, @solutions
    end

    def update

    end

  end
