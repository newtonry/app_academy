class TowersOfHanoi
  def initialize
    @pegs = [[1], [2], [3]]
  end

  def start
    until game_won?
      print_board
      while true
        sp, ep = get_next_move
        break if make_move(sp, ep)
      end
    end
  end

  private
    def print_board
      @pegs.each { |peg| p peg }
    end

    def get_next_move
      print "Enter start-peg and end-peg: "

      gets.chomp.split(" ").map { |i| i.to_i }
    end

    def make_move(sp, ep)
      if valid_move?(sp, ep)
        @pegs[ep-1].push(@pegs[sp-1].pop)
        true
      else
        false
      end
    end

    def valid_move?(sp, ep)
      return false if (sp > @pegs.length || ep > @pegs.length)
      return false if @pegs[sp-1].empty?
      return true if @pegs[ep-1].empty?

      @pegs[sp-1].last < @pegs[ep-1].last
    end

    def game_won?
      @pegs.reject {|peg| peg.length == 0 }.count == 1
    end

end

TowersOfHanoi.new.start