class Croupier < Player
  def auto_move
    take_card if hand.amt_points < 17
  end
end
