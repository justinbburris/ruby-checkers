class Checkers
  require 'board'
  require 'piece'

  REGULAR_MOVE = 'regular_move'
  JUMP_MOVE    = 'jump_move'
  
  # Setup basic game and give control to black
  def initialize()
    @board = Board.new()
    @players = [Piece.new(Piece::BLACK), Piece.new(Piece::RED)]
    @current_player = @players[0]

    puts 'Welcome to Ruby Checkers.'
    puts '========================='
    puts ': Make moves by specifying which piece you want to move'
    puts 'and where you want it to move to'
    puts 'E.G. Inputting "1,2" will move the piece at grid pos. 1,2'
    puts '========================='
    puts ': Quit at any time by typing "quit"'
    
    print 'Please a key to begin:'
    gets

    # Start the game!
    play
  end

  private
  
  def play
    # Game loop
    while true do
      puts '----------------------------'
      @board.print_board

      print "Your move #{@current_player.color} : "
      from = get_move
      break if from.nil?
      
      print 'Where do you want it to go? : '
      to = get_move
      break if to.nil?

      if validate_move(from,to)
        puts "Great! Let's move your piece"
        @board.move_piece(from,to)
        switch_players
      else
        puts "Sorry, that's not a valid move!"
        puts "Please try again"
      end
    end
  end

  def validate_move(from,to)
    # Piece exists?
    return false if @board.fetch_piece(from).nil?
    
    # Piece belongs to current player?
    return false if @board.fetch_piece(from).color != @current_player.color
    
    # Can they move go there?
    return false unless valid_move?(from,to)

    return true
  end

  # Checks to make sure the move is valid
  def valid_move?(from,to)
    from_square = @board.fetch_square(from)
    to_square   = @board.fetch_square(to)

    # Square is empty and of same color
    return false unless to_square.empty? && to_square.color == from_square.color

    # Square is inside regular legal move area
    unless moveable_area(REGULAR_MOVE, from).include? to
      # If it's not a regular move, is it a jump?
      puts 'jump?'
      return false unless moveable_area(JUMP_MOVE, from).include? to
    end

    true
  end

  # Pieces can only move diagonally one square
  # Or they can jump diagonally two squares
  # Kings can move everywhere, though not sure how to test for king.
  def moveable_area(move_type, location)
    Board::JUMP_DIRECTIONS.inject([]) do |area, direction|
      area << self.send(move_type, direction, location)
    end.compact
  end

  def regular_move(direction, location)
    move = @board.send(direction, location)
    begin
      return @board.empty_square?(move) ? move : nil
    rescue SquareOutOfBoundsError
      return nil
    end
  end
  
  # Returns the coordinates the piece can jump to in a specific direction
  # Elsewise returns nil
  def jump_move (direction, location)
    move = regular_move(direction, location)
    unless move.nil?
      piece = @board.fetch_piece(move)
      if piece && (piece.color != @board.fetch_piece(location).color)
        move = regular_move(direction, move)
        unless move.nil?
          return @board.empty_square?(move) ? move : nil
        end
      end
    end
    return nil
  end
      
  def get_move
    input = gets.chomp
    return nil if quit?(input)
    input.split(',').map { |x| x.to_i }
  end
  
  def quit? input
    return input == 'quit' ? true : false
  end
    
  def switch_players
    @players << @players.delete_at(0)
    @current_player = @players[0]
  end
    
end
