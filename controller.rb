
class Controller
  #singleton?

  #what object stores the reference?
  attr_accessor :knowledge_sources, :blackboard

  def initialize (blackboard)
    @blackboard = blackboard
    @knowledge_sources = Array.new
  end

  def loop
    begin

      @knowledge_sources.each do |ks|
        next_source (ks)
      end
      rec = @blackboard.conclusion
    end while user_rejected(rec) == true

  end

  def next_source(ks)
    puts ks

    if ks.exec_condition != false
      ks.exec_action          #fix this for priority
      ks.update(@blackboard)
    end

  end

  def user_rejected(rec)
    input = gets.chomp
    if input == "no"
      @blackboard.rejection(rec)
      return true
    else
      return false
    end
  end


end
