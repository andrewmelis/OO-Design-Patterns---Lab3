
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
  end

  def next_source(ks)
    ks.exec_condition
  end

  

end