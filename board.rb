class Board
  require 'Square'
  require 'Piece'
  attr_reader :board
  
  def initialize()
    @board = {}
    colors = [Square::BLACK, Square::WHITE]
        
    (1..8).each do |row|
      (1..8).each do |col|
        sq = Square.new(colors[0])

        # Place starting pieces on board
        if (1..3).include?(row) && sq.color == Square::BLACK
          sq.checker_piece = Piece.new(Piece::BLACK)
        elsif (6..8).include?(row) && sq.color == Square::BLACK
          sq.checker_piece = Piece.new(Piece::RED)
        end
        
        @board[[row,col]] = sq
        
        colors << colors.delete_at(0) unless col == 8
      end
    end
  end

  #Print out of board for debugging
  def print_board
    (1..8).each do |row|
      row_colors = []
      (1..8).each do |col|
        row_colors << @board[[row,col]].console_rep
      end
      puts row_colors.join(' ')
    end
  end
  
end

