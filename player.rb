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

  protected

  attr_writer :cash
end
