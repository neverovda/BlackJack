class Player
  CASH_FOR_VICTORY = 10

  attr_reader :cash

  def initialize
    @cash = 100
    @hand = Hand.new
  end

  def lost_round
    @cash -= CASH_FOR_VICTORY
  end

  def win_round
    @cash += CASH_FOR_VICTORY
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

  def higher_21?
    amt_points > 21
  end

  protected

  attr_reader :card_deck, :hand
  attr_writer :cash
end
