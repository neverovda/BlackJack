class Player
  attr_reader :cash

  def initialize
    @cash = 100
    @hand = Hand.new
  end

  def lost_round
    @cash -= 10
  end

  def win_round
    @cash += 10
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

  def amt_points
    hand.amt_points
  end

  protected

  attr_reader :card_deck, :hand
  attr_writer :cash
end
