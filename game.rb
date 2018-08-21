require_relative 'card_deck'
require_relative 'hand'
require_relative 'player'
require_relative 'croupier'

class GameProcess
  attr_reader :player, :croupier

  def initialize
    @player = Player.new
    @croupier = Croupier.new
    change_deck
    start
  end

  def start
    loop do
      break if round == :exit
    end
  end

  def round
    give_out_cards
    show_cards_together(:hidden)

    p '1. Pass'
    p '2. Take card'
    p '3. Open cards'
    p '0. Abort the game'

    case selection_number
    when 1
      croupier.auto_move
    when 2
      player.take_card
      croupier.auto_move
    when 0
      return :exit
    end
    round_result
    ovarall_result
    discard_and_mix
  end

  protected

  attr_accessor :card_deck

  SUITS = { diamonds: "\u{2666}", hearts: "\u{2665}",
            clubs: "\u{2663}", spades: "\u{2660}" }.freeze

  def change_deck
    self.card_deck = CardDeck.new
    player.associate_whish_deck(card_deck)
    croupier.associate_whish_deck(card_deck)
    puts 'The cards are mixed'
   end

  def selection_number
    gets.chomp.to_i
  end

  def show_cards(cards)
    cards.each { |card| print "#{card[:rang]}#{SUITS[card[:suit]]} " }
    puts
  end

  def show_hidden_cards(cards)
    cards.each { |_card| print "\u{25a1}  " }
    puts
  end

  def show_cards_together(show)
    print 'You    > '
    show_cards(player.cards)
    print 'Casino > '
    show_cards(croupier.cards) if show == :evident
    show_hidden_cards(croupier.cards) if show == :hidden
  end

  def give_out_cards
    2.times do |_n|
      player.take_card
      croupier.take_card
    end
  end

  def round_result
    show_cards_together(:evident)
    print "You points: #{player.amt_points}. "
    puts "Croupier points: #{croupier.amt_points}."

    if (player.amt_points == croupier.amt_points) ||
       (player.higher_21? && croupier.higher_21?)
      puts 'The round is over. Draw.'
    elsif croupier.higher_21? ||
          (player.amt_points > croupier.amt_points && player.not_higher_21?)
      you_win_round
    else
      casino_win_round
    end
  end

  def you_win_round
    puts 'You win round.'
    player.win_round
    croupier.lost_round
  end

  def casino_win_round
    puts 'Casino win round.'
    player.lost_round
    croupier.win_round
  end

  def ovarall_result
    puts "CASH     your:#{player.cash}$  croupier:#{croupier.cash}$ "

    if player.cash.zero?
      puts 'YOU WINNER!'
      :exit
    end

    if croupier.cash.zero?
      puts 'YOU LOSER!'
      :exit
    end
  end

  def discard_and_mix
    player.discard_cards
    croupier.discard_cards
    change_deck if card_deck.time_to_mix?
  end
end

loop do
  GameProcess.new
  print 'Do you want to play more? (Y/N)'
  answer = gets.chomp
  break if answer !~ /Y/i
end
