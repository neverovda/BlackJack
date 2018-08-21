class CardDeck
  SUIT = %i[clubs diamonds hearts spades].freeze
  RANG_WITH_POINTS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                       '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
                       'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  def initialize
    @cards = []
    RANG_WITH_POINTS.each do |rang, points|
      SUIT.each { |suit| @cards << make_card(rang, suit, points) }
    end
    @cards.shuffle!
  end

  def make_card(rang, suit, points)
    { rang: rang, suit: suit, points: points }
  end

  def take_card
    @cards.pop
  end

  def time_to_mix?
    @cards.length < Settings::REST_CARD_DECK
  end
end
