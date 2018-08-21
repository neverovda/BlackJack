require_relative 'lib/settings'
require_relative 'lib/card_deck'
require_relative 'lib/hand'
require_relative 'lib/player'
require_relative 'lib/croupier'
require_relative 'lib/game_process'

loop do
  GameProcess.new
  print 'Do you want to play more? (Y/N)'
  answer = gets.chomp
  break if answer !~ /Y/i
end
