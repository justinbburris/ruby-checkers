class Board
  require 'Square'
  require 'Piece'
  attr_reader :board

  # Creates a basic game board, starting pieces on black spaces
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

  #Print out of board for console play
  def print_board
    col_numbers = [' ']
    (1..8).each do |row|
      row_items = []

      col_numbers << ' ' + row.to_s + ' '
      row_items << row
      
      (1..8).each do |col|
        row_items << @board[[row,col]].console_rep
      end

      puts row_items.join(' ')
    end
    puts col_numbers.join(' ')
  end

  # Moves piece from [x1,y1] to [x2,y2]
  def move_piece(from, to)
    return move_piece_in_square(@board[from], @board[to])
  end
  
  private
  
  # Moves a piece to a new square if square is empty and the square
  # color matches
  def move_piece_in_square(from_square, to_square)
    if to_square.empty? && to_square.color == from_square.color
      to_square.checker_piece = from_square.checker_piece
      from_square.checker_piece = nil
      return true
    else
      return false
    end
  end
      
end

