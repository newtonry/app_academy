#doesn't pick out best solution yet, just one solution

class MazeSolver
  def initialize filename
    @filename = filename
    @maze = read_file

    print_maze

    start_solving(find_start, [])



  end

  private

  def start_solving position, pos_history

    options = get_options(position, pos_history)
    if options.empty?
      return nil
    end


    options.each do |option|
      if @maze[option[0]][option[1]] == :E
        puts "WINNER"
        #p pos_history
        fill_in_solved_maze pos_history
        return "WIN"
      end

      pos_history << option
      start_solving(option, pos_history)

    end


  end


  def read_file
    File.open(@filename, 'r') do |file|
      file.read.split("\n").map do |line|
        line.split('').map do |element|

          if element == " "
            nil
          else
            element.to_sym
          end
        end
      end
    end
  end

  def get_options position, pos_history
    position_options = []
    x = position[1]
    y = position[0]

    position_options << [y, x+1] if is_valid_move?(y, x+1, pos_history)
    position_options << [y, x-1] if is_valid_move?(y, x-1, pos_history)
    position_options << [y+1, x] if is_valid_move?(y+1, x, pos_history)
    position_options << [y-1, x] if is_valid_move?(y-1, x, pos_history)

    position_options
  end

  def is_valid_move? y, x, pos_history
    return :E if @maze[y][x] == :E
    @maze[y][x].nil? and !pos_history.include?([y, x])

  end


  def find_start
    @maze.each_with_index do |line, line_ind|
       if index = line.index(:S)
         return [line_ind, index]
       end
    end
  end

  def print_maze
    @maze.each do |line|
      visual_string = ''
      line.each do |element|
        if element.nil?
          visual_string << " "
        else
          visual_string << element.to_s
        end
      end
      p visual_string

    end
  end

  def fill_in_solved_maze solution
    solution.each do |pos|
      @maze[pos[0]][pos[1]] = "X"
    end

    print_maze
  end


end

MazeSolver.new("example_maze.txt")

