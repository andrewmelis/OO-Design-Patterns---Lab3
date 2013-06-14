#represents a hypothesis to blackboard solution

class Hypothesis
  attr_accessor :song_rec, :recommender

  def initialize (song_rec, recommender)
    @song_rec = song_rec
    @recommender = recommender
  end

end