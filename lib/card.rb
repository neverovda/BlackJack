class Card
  attr_reader :rang, :suit, :points
  attr_writer :points

  def initialize(args)
    @rang = args[:rang]
    @suit = args[:suit]
    @points = args[:points]
  end
end
