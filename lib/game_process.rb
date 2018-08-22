class GameProcess
  def initialize(interface)
    @interface = interface
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

  attr_reader :player, :croupier, :interface
  attr_accessor :card_deck

  def round
    begin_round
    return :exit if choice == :exit
    round_result
  end

  def begin_round
    interface.separate_rounds
    interface.current_cash(player.cash, croupier.cash)
    discard_and_mix
    give_out_cards
  end

  def choice
    case interface.make_choice
    when 1
      croupier.auto_move
    when 2
      player.take_card
      croupier.auto_move
    when 0
      :exit
    end
  end

  def change_deck
    self.card_deck = CardDeck.new
    interface.cards_mix
    player.associate_whish_deck(card_deck)
    croupier.associate_whish_deck(card_deck)
  end

  def give_out_cards
    2.times do
      player.take_card
      croupier.take_card
    end
    interface.show_cards_hidden(player.cards, croupier.cards.length)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  def round_result
    interface.show_cards_evident(player.cards, croupier.cards)
    interface.current_points(player.amt_points, croupier.amt_points)

    return interface.draw if player.amt_points == croupier.amt_points
    return interface.draw if player.excess? && croupier.excess?
    return win_round if croupier.excess?
    return lose_round if player.excess?
    return win_round if player.amt_points > croupier.amt_points
    lose_round
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize

  def win_round
    interface.win_round
    player.win_round
    croupier.lost_round
    overall_result
  end

  def lose_round
    interface.lose_round
    player.lost_round
    croupier.win_round
    overall_result
  end

  def overall_result
    totals = { player.cash => :lose_game, croupier.cash => :win_game }
    return unless totals.key?(0)
    interface.send(totals[0])
    :exit
  end

  def discard_and_mix
    player.discard_cards
    croupier.discard_cards
    change_deck if card_deck.time_to_mix?
  end
end
