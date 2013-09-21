class Game

  attr_accessor :players

  def initialize
    @players = []
    play
  end

  def add_players(num_humans)
    raise "Too many players" if num_humans > 2
    num_humans.times {@players << HumanPlayer.new}
    until @players.count == 2
      @players << ComputerPlayer.new
    end
  end

  def play
    puts "Please give the number of players from 0 - 2"
    add_players(gets.chomp.to_i)
    board = Board.new
    board.print_board
    loop do
      board.draw(@players[0].make_move(board),"X")
      board.print_board

      if board.game_won?
        puts "Player 1 wins!"
        break
      end

      board.draw(@players[1].make_move(board),"O")
      board.print_board

      if board.game_won?
        puts "Player 2 wins!"
        break
      end

    end
  end



end

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(3){|arr| Array.new(3)}
  end

  def print_board
    @board.each do |line|
      p line
    end
    p ""
  end

  def draw(move, marker)
    @board[move[0]][move[1]] = marker unless @board[move[0]][move[1]]
  end

  def game_won?
    winner_indices = [
      [[0,0], [0,1],[0,2]],
      [[1,0], [1,1],[1,2]],
      [[2,0], [2,1],[2,2]],

      [[0,0], [1,0],[2,0]],
      [[0,1], [1,1],[2,1]],
      [[0,2], [1,2],[2,2]],

      [[0,0], [1,1],[2,2]],
      [[2,0], [1,1],[0,2]]
      ]

      winner_indices.each do |possibility|
        values = get_values(possibility)
        return true if values.uniq.length == 1 and !values[0].nil?
      end

    false
  end

  def get_values possibilities
    possibilities.map do |position|
      @board[position[0]][position[1]]
    end
  end
end



class HumanPlayer
  def make_move(board)
    move = []
    loop do
      puts "Please pick your square as a 'row,column' between 0-2"
      move = gets.chomp.split(',').map {|num| num.to_i}
      break if board.board[move[0]][move[1]] == nil
    end
    move
  end
end


class ComputerPlayer
  def make_move(board)
    move = check_for_win_move(board)
    if move
      return move
    end
    move = []
    loop do
      move = [(0..2).to_a.sample,(0..2).to_a.sample]
      break if board.board[move[0]][move[1]] == nil
    end
    move
  end

  def check_for_win_move(board)
    valid_moves = []
    (0..2).each do |i|
      (0..2).each do |j|
       valid_moves << [i,j] if board.board[i][j].nil?
       end
    end
    marker = valid_moves.length % 2 == 0 ? "O" : "X"
    valid_moves.each do |move|
      board_copy = Marshal.load(Marshal.dump(board))
      board_copy.draw(move, marker)
      return move if board_copy.game_won?
    end
    false
  end
end

game = Game.new
