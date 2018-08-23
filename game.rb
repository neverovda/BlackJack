require_relative 'lib/settings'
require_relative 'lib/text_interface'
require_relative 'lib/card'
require_relative 'lib/card_deck'
require_relative 'lib/hand'
require_relative 'lib/player'
require_relative 'lib/croupier'
require_relative 'lib/game_process'

interface = TextInterface.new
loop do
  GameProcess.new(interface)
  break unless interface.play_more?
end
