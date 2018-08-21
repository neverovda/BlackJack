require_relative 'card_deck'
require_relative 'hand'
require_relative 'player'
require_relative 'croupier'

class GameProcess
  attr_reader :card_dec, :player, :croupier

  def initialize
    @player = Player.new
    @croupier = Croupier.new
    change_deck
    start
  end

  def start
    give_out_cards
    show_cards(player.cards)
    show_cards(croupier.cards) # must be hidden

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

    round_result
  end

  protected

  attr_writer :card_deck

  SUITS = { diamonds: "\u{2666}", hearts: "\u{2665}",
            clubs: "\u{2663}", spades: "\u{2660}" }.freeze

  def change_deck
    card_deck = CardDeck.new
    player.associate_whish_deck(card_deck)
    croupier.associate_whish_deck(card_deck)
  end

  def selection_number
    gets.chomp.to_i
  end

  def show_cards(cards)
    srt = ''
    cards.each { |card| srt += "#{card[:rang]}#{SUITS[card[:suit]]} " }
    puts srt
  end

  def give_out_cards
    2.times do |_n|
      player.take_card
      croupier.take_card
    end
  end

  def round_result
    p "You points #{player.amt_points}"
    p "Croupier points #{croupier.amt_points}"

    if (player.amt_points == croupier.amt_points) ||
       (player.higher_21? && croupier.higher_21?)
      p 'Draw'
    elsif croupier.higher_21? ||
          (player.amt_points > croupier.amt_points && player.not_higher_21?)
      you_win_round
    else
      casino_win_round
    end
  end

  def you_win_round
    p 'You win'
    player.win_round
    croupier.lost_round
  end

  def casino_win_round
    p 'Casino win'
    player.lost_round
    croupier.win_round
  end
end

GameProcess.new
