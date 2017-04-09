# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # class array holding all the pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               #new pieces 
               rotations([[0, 0], [0, -1], [1, 0], [2, 0], [1, -1]]), #L plus 1
               [[[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]], # long5 
                [[0, 0], [0, -1], [0, 1], [0, -2], [0, 2]]],
               rotations([[0, 0], [1, 0], [0, -1]])] # small L 

  # class method to choose the next piece
  def self.next_piece (board, cheat=false)
    if not cheat
      MyPiece.new(All_My_Pieces.sample, board)
    else 
      MyPiece.new([[[0, 0]]], board)
    end
  end
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    super
    @current_block = MyPiece.next_piece(self, false)
    @cheat = false
  end

  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size-1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self, @cheat)
    @current_pos = nil
    @cheat = false
  end
  
  # rotate 180 degree
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end
  
  # cheat
  def cheat
    if !game_over? and @game.is_running? and @score >= 100 and not @cheat
      @score -= 100
      @cheat = true
    end
  end 
end

class MyTetris < Tetris
  # your enhancements here
  # creates a canvas and the board that interacts with it
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings  
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end
end

