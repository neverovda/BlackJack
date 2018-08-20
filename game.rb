require_relative 'card_deck'
require_relative 'hand'
require_relative 'player'
require_relative 'croupier'

SUITS = { diamonds: "\u{2666}", hearts: "\u{2665}",
          clubs: "\u{2663}", spades: "\u{2660}" }.freeze

def selection_number
  gets.chomp.to_i
end

def show_cards(cards)
  srt = ''
  cards.each { |card| srt += "#{card[:rang]}#{SUITS[card[:suit]]}" }
  puts srt
end

card_deck = CardDeck.new
player = Player.new
croupier = Croupier.new

player.associate_whish_deck(card_deck)
croupier.associate_whish_deck(card_deck)

player.take_card
player.take_card

show_cards(player.cards)

croupier.take_card
croupier.take_card

show_cards(croupier.cards)

p '1. Pass'
p '2. Take card'
p '3. Open cards'

case selection_number
when 1
  croupier.auto_move
when 2
  player.take_card
  croupier.auto_move
  show_cards(player.cards)
  show_cards(croupier.cards)
when 3
  show_cards(player.cards)
  show_cards(croupier.cards)
end

p "You points #{player.amt_points}"
p "Croupier points #{croupier.amt_points}"

if (player.amt_points == croupier.amt_points) ||
   (player.amt_points > 21 && croupier.amt_points > 21)
  p 'Draw'
elsif croupier.amt_points > 21 || (player.amt_points > croupier.amt_points)
  p 'You win'
elsif player.amt_points > 21 || (player.amt_points < croupier.amt_points)
  p 'Casino win'
else
  p 'Error'
end
