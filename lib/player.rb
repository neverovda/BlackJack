class Player
  attr_reader :cash

  def initialize
    @cash = Settings::INITIAL_DEPOSIT
    @hand = Hand.new
  end

  def lost_round
    @cash -= Settings::CASH_FOR_VICTORY
  end

  def win_round
    @cash += Settings::CASH_FOR_VICTORY
  end

  def associate_whish_deck(card_deck)
    @card_deck = card_deck
  end

  def take_card
    hand.take_card(card_deck)
  end

  def cards
    hand.cards
  end

  def discard_cards
    hand.clear
  end

  def amt_points
    hand.amt_points
  end

  def excess?
    amt_points > Settings::LIMIT_OF_POINTS
  end

  protected

  attr_reader :card_deck, :hand
  attr_writer :cash
end
