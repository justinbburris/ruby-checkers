class Square
  # Square color options
  BLACK = :black
  WHITE = :white
  attr_reader :color

  # Square checker options
  attr_accessor :checker_piece
    
  def initialize(color)
    @color = color
  end

  def console_rep
    # I'm not comfortable with how I have to read these pieces colors
    piece = self.empty? ? '_' : @checker_piece.console_rep
    
    return @color == BLACK ? "|#{piece}|" : "_#{piece}_"
  end
  
  # Checks if there is currently a checker piece on the board in this square
  def empty?
    return @checker_piece.nil? ? true : false
  end
end
