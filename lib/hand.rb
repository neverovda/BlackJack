class Hand
  attr_reader :cards

  def initialize
    clear
  end

  def take_card(card_deck)
    @cards << card_deck.take_card
  end

  def amt_points
    total = sum_points
    if total > 21 && ace_eleven_in_deck?
      change_ace_eleven_points!
      total = amt_points
    end
    total
  end

  def clear
    @cards = []
  end

  protected

  def sum_points
    total = 0
    cards.each { |card| total += card[:points] }
    total
  end

  def first_ace_eleven
    @cards.find { |card| card[:rang] == 'A' && card[:points] == 11 }
  end

  def ace_eleven_in_deck?
    return true if first_ace_eleven
    false
  end

  def change_ace_eleven_points!
    ace_eleven = first_ace_eleven
    ace_eleven[:points] = 1
  end
end
