class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def take_card(card_deck)
    @cards << card_deck.take_card
  end

  def amt_card
    cards.length
  end

  def amt_points
    total = sum_points
    total = amt_points if total > 21 && change_points
    total
  end

  protected

  def sum_points
    total = 0
    cards.each { |card| total += card[:points] }
    total
  end

  def change_points
    ace_eleven = cards.find { |card| card[:rang] == 'A' && card[:points] == 11 }
    return false unless ace_eleven
    ace_eleven[:points] = 1
    true
  end
end
