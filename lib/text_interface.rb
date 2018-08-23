class TextInterface
  SUITS = { diamonds: "\u{2666}", hearts: "\u{2665}",
            clubs: "\u{2663}", spades: "\u{2660}" }.freeze

  def show_cards_evident(player_cards, croupier_cards)
    the_known_parts(player_cards)
    show_cards(croupier_cards)
  end

  def show_cards_hidden(player_cards, amt_croupier_cards)
    the_known_parts(player_cards)
    amt_croupier_cards.times { print "\u{25a1}  " }
    puts
  end

  def the_known_parts(cards)
    print 'You    > '
    show_cards(cards)
    print 'Casino > '
  end

  def show_cards(cards)
    cards.each { |card| print "#{card.rang}#{SUITS[card.suit]} " }
    puts
  end

  def play_more?
    puts 'Do you want to play more? (Y/N)'
    print '> '
    answer = gets.chomp
    answer =~ /Y/i
  end

  def separate_rounds
    80.times { print '-' }
    puts
  end

  def make_choice
    loop do
      puts '1. Pass'
      puts '2. Take card'
      puts '3. Open cards'
      puts '0. Abort the game'
      print '> '
      num = gets.chomp.to_i
      return num if (num.is_a? Integer) && num.between?(0, 3)
      puts 'invalid input'
    end
  end

  def current_cash(player, croupier)
    puts "CASH     your: #{player}$  croupier: #{croupier}$"
  end

  def cards_mix
    puts 'The cards are mixed'
  end

  def current_points(player, croupier)
    print "You points: #{player}. "
    puts "Croupier points: #{croupier}."
  end

  def draw
    puts 'The round is over. Draw.'
  end

  def win_round
    puts 'You win round.'
  end

  def lose_round
    puts 'Casino win round.'
  end

  def win_game
    puts 'YOU WINNER!'
  end

  def lose_game
    puts 'YOU LOSER!'
  end
end
