class Hand
  attr_reader :cards

  def initialize
    clear
  end

  def take_card(card_deck)
    @cards << card_deck.take_card
  end

  def amt_points
    total = cards.map(&:points).sum
    if total > Settings::LIMIT_OF_POINTS && first_ace_eleven
      first_ace_eleven.points = 1
      total = amt_points
    end
    total
  end

  def clear
    @cards = []
  end

  protected

  def first_ace_eleven
    @cards.find { |card| card.rang == 'A' && card.points == 11 }
  end
end
