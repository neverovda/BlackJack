class Croupier < Player
  def auto_move
    take_card if hand.amt_points < Settings::LIMIT_FOR_AUTOMOVE
  end
end
