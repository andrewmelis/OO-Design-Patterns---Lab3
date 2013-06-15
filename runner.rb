require_relative 'blackboard'
require_relative 'controller'
require_relative 'knowledge_source'
require_relative 'authentication'

blackboard = Blackboard.new
auth = Authenticator.new(blackboard)
controller = Controller.new(blackboard)
user = User.new(controller)
similar_track = SimilarTrack.new(controller)
similar_artist = SimilarArtists.new(controller)
play_count = PlayCount.new(controller)

controller.loop
