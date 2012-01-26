class Checkers
  require 'Board'
  require 'Piece'
  
  # Setup basic game and give control to black
  def initialize()
    @board = Board.new()
    @players = [Piece.new(Piece::BLACK), Piece.new(Piece::RED)]
  end

  def play
    puts 'Welcome to Ruby Checkers.'
    puts '========================='
    puts ': Make moves by specifying which piece you want to move'
    puts 'and where you want it to move to'
    puts 'E.G. Inputting "1,2" will move the piece at grid pos. 1,2'
    puts '========================='
    puts ': Quit at any time by typing "quit"'
    
    print 'Please a key to begin:'
    gets

    while true do
      puts '----------------------------'
      @board.print_board
      print "Your move #{@players[0].color} : "

      from = get_move
      break if from.nil?
      
      print 'Where do you want it to go? : '
      to = get_move
      break if to.nil?

      valid_move = @board.move_piece(from,to)
      if valid_move
        puts "Great! Let's move your piece"
        switch_players
      else
        puts "Sorry, that's not a valid move!"
        puts "Please try again"
      end
    end
        
  end

  private

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
  end
    
end
