class GameProcess
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

  protected

  attr_reader :player, :croupier
  attr_accessor :card_deck

  SUITS = { diamonds: "\u{2666}", hearts: "\u{2665}",
            clubs: "\u{2663}", spades: "\u{2660}" }.freeze

  def round
    begin_round
    return :exit if choice == :exit
    round_result
  end

  def begin_round
    puts "CASH     your:#{player.cash}$  croupier:#{croupier.cash}$ "
    discard_and_mix
    give_out_cards
    show_cards_together(:hidden)
  end

  def choice
    print_choise
    case selection_number
    when 1
      croupier.auto_move
    when 2
      player.take_card
      croupier.auto_move
    when 0
      :exit
    end
  end

  def print_choise
    puts '1. Pass'
    puts '2. Take card'
    puts '3. Open cards'
    puts '0. Abort the game'
  end

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

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  def round_result
    show_cards_together(:evident)
    print "You points: #{player.amt_points}. "
    puts "Croupier points: #{croupier.amt_points}."

    return draw if player.amt_points == croupier.amt_points
    return draw if player.higher_21? && croupier.higher_21?
    return you_win_round if croupier.higher_21?
    return casino_win_round if player.higher_21?
    return you_win_round if player.amt_points > croupier.amt_points
    casino_win_round
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize

  def draw
    puts 'The round is over. Draw.'
  end

  def you_win_round
    puts 'You win round.'
    player.win_round
    croupier.lost_round
    overall_result
  end

  def casino_win_round
    puts 'Casino win round.'
    player.lost_round
    croupier.win_round
    overall_result
  end

  def overall_result
    totals = { player.cash => 'YOU LOSER!', croupier.cash => 'YOU WINNER!' }
    return unless totals.key?(0)
    puts totals[0]
    :exit
  end

  def discard_and_mix
    player.discard_cards
    croupier.discard_cards
    change_deck if card_deck.time_to_mix?
  end
end
