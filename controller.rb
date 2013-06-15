
class Controller
  #singleton?

  #what object stores the reference?
  attr_accessor :knowledge_sources, :blackboard

  def initialize (blackboard)
    @blackboard = blackboard
    @knowledge_sources = Array.new
  end

  def loop
    @knowledge_sources.each do |ks|
      next_source (ks)
    end
    @blackboard.conclusion
  end

  def next_source(ks)
    puts ks
    if ks.exec_condition != false
      ks.exec_action          #fix this for priority
      ks.update(@blackboard)
    end

  end

end