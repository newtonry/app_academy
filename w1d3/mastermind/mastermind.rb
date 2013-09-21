class Mastermind
  def initialize
    @board = Board.new()
    @player = Player.new()
    @guesses = 0
  end

  def run
    while @guesses < 10
      guess = @player.prompt_guess
      @guesses += 1

      guess_result = @board.check_guess guess

      if guess_result[0] == 4
        puts "You've won in #{@guesses} tries"
        return
      end

      puts "You've got #{guess_result[0]} guesses right, #{guess_result[1]} guesses close. You have #{10 - @guesses} left."
    end

    puts "You've lost in 10 guesses. The code was #{@board.code.to_s.gsub("\"", "")}"
  end
end


class Board
  COLORS = %w(R G B Y O P)
  attr_reader :code

  def initialize
    @code = generate_code
  end

  def generate_code
    [].tap do |code|
      4.times { code << COLORS.sample }
    end
  end

  def check_guess guess
    exact, near = [], []
    code_dup = @code.dup

    guess.each_index do |index|
      if guess[index] == code[index]
        exact << index
        code_dup[index] =  nil
      end
    end

    guess.each_index do |index|
      if code_dup.include?(guess[index])
        near << index
        code_dup[code_dup.index(guess[index])] = nil
      end
    end

    [exact.length, near.length]
  end

  def self.validate_guess(guess)
    validated = guess.scan(/[RGBYOP]/)
    guess.gsub(/\s+/, "").length == 4 && validated.length == 4 ? validated : nil
  end
end


class Player
  def prompt_guess
    while true
      puts "Enter your 4-color guess #{Board::COLORS.to_s.gsub("\"", "")}:"
      guess = Board.validate_guess(gets.upcase)
      if guess != nil
        return guess
      end
      puts "Invalid guess!"
    end
  end
end

Mastermind.new.run