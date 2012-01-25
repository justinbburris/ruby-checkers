class Piece
  # Piece color options
  BLACK = :black
  RED   = :red
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def console_rep
    return color == BLACK ? 'B' : 'R'
  end
    
end
