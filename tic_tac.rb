# This is some bad coding where I repeat a ton of stuff
# Plan on fixing soon
class Board
  def initialize
    @board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
  end

  attr_accessor :board

  def display_board
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} ".center(10)
    puts "------------".center(10)
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} ".center(10)
    puts "------------".center(10)
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} ".center(10)
  end
end

class Player
  def initialize(name)
    @name = name
  end
  def get_name
  @name
  end
  def get_move
    print "x-position: "
    x = gets.chomp.to_i - 1
    print "y-position: "
    y = gets.chomp.to_i - 1
    return x, y
  end
end


class Player1 < Player
  def make_x_move(current_board)
    indicator = true
    while indicator
      tile1, tile2 = get_move
      puts "this is it:", current_board.board[tile2][tile1].match?(/\w/)
      if tile1.between?(0, 2) && tile2.between?(0, 2) && !(current_board.board[tile2][tile1].match?(/\w/))
        current_board.board[tile2][tile1] = "X"
        indicator = false
      else
        puts "not a valid move"
      end
    end
  end
end

class Player2 < Player
  def make_o_move(current_board)
    indicator = true
    while indicator
      tile1, tile2 = get_move
      puts current_board.board[tile2][tile1]
      if tile1.between?(0, 2) && tile2.between?(0, 2) && !(current_board.board[tile2][tile1].match?(/\w/))
        current_board.board[tile2][tile1] = "O"
        indicator = false
      else
        puts "not a valid move"
      end
    end
  end
end


class GameEngine
  def initialize(current_board)
    puts "Player 1, please enter your name:"
    name1 = gets.chomp
    player1 = Player1.new(name1)

    puts "Player 2, please enter your name:"
    name2 = gets.chomp
    player2 = Player2.new(name2)

    def check_win(current_board)
      i = 0
      validator = false
      transposed_board = current_board.board.transpose

      3.times do |i|
        if current_board.board[i].all? { |xy| xy == "X" }
          puts "Player 1, you've won!"
          validator = true
          break
        elsif transposed_board[i].all? { |xy| xy == "X" }
          puts "Player 1, you've won!"
          validator = true
          break
        elsif current_board.board[0][0] == "X" && current_board.board[1][1] == "X" && current_board.board[2][2] == "X"
          puts "Player 1, you've won!"
          validator = true
          break
        elsif current_board.board[0][2] == "X" && current_board.board[1][1] == "X" && current_board.board[2][0] == "X"
          puts "Player 1, you've won!"
          validator = true
          break
        else
          i += 1
        end
      end

      3.times do |i|
        if current_board.board[i].all? { |xy| xy == "O" }
          puts "Player 2, you've won!"
          validator = true
          break
        elsif transposed_board[i].all? { |xy| xy == "O" }
          puts "Player 2, you've won!"
          validator = true
          break
        elsif current_board.board[0][0] == "O" && current_board.board[1][1] == "O" && current_board.board[2][2] == "O"
          puts "Player 2, you've won!"
          validator = true
          break
        elsif current_board.board[0][2] == "O" && current_board.board[1][1] == "O" && current_board.board[2][0] == "O"
          puts "Player 2, you've won!"
          validator = true
          break
        else
          i += 1
        end
      end
      return validator
    end

    tac_array = Array(2..10)

    tac_array.each do |i|
      if check_win(current_board) == true
        break
      end

      if i % 2 == 0
        puts "\n#{player1.get_name}, make your move."
        player1.make_x_move(current_board)
      else
        puts "\n#{player2.get_name}, make your move."
        player2.make_o_move(current_board)
      end

    puts "\n"
    puts current_board.display_board
    end
  end
end

game_board = Board.new
new_game = GameEngine.new(game_board)
