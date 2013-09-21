#!/usr/bin/env ruby

class Tree
  attr_reader :nodes, :root

  def initialize(value = 0)
    @root = TreeNode.new(value)
    @nodes = [@root]
  end

  def print_tree(node=@root)
    if node.children.empty?
      [node.value]
    else
      [node.value] + node.children.map { |child| print_tree(child) }
    end
  end

  def dfs(target = 0, stack = [@root], &prc)
    element = stack.pop
    return nil if element.nil?

    if block_given?
      return element if prc.call(element)
    else
      return element if element.value == target
    end

    element.children.reverse.each do |child|
      stack << child
    end
    # stack.push *element.children.reverse

    dfs(target, stack, &prc)
  end

  def bfs(target = 0, stack = [@root], &prc)
    element = stack.shift
    return nil if element.nil?

    if block_given?
      return element if prc.call(element)
    else
      return element if element.value == target
    end

    element.children.each do |child|
      stack << child
    end

    bfs(target, stack, &prc)
  end

  def insert(parent, value, index = 0)
    new_node = TreeNode.new(value)
    insert_at = [index, parent.children.size].min

    parent.add_child(insert_at, new_node)

    @nodes << new_node
  end
end

class TreeNode
  attr_reader :parent
  attr_accessor :value, :children

  def initialize value
    @parent = nil
    @value = value
    @children = []
  end

  def next_sibling
    if @parent
      own_index = @parent.children.find_index(self)
      @parent.children[own_index+1]
    else
      nil
    end
  end

  def parent=(new_parent)
    @parent.child = nil unless @parent.nil?
    @parent = new_parent
  end

  def add_child(index, child)
    @children.insert(index, child)
    child.parent=self
  end

  def children
    @children.compact
  end

  def path
    if self.parent.nil?
      [self.value]
    else
      self.parent.path + [self.value]
    end
  end
end



class KnightPathFinder
  def initialize(start_square = [0,0])
    @start_coord = start_square
  end

  def find_path(end_square = [7,7])
    return end_square if end_square == @start_coord
    # return "INVALID END SQUARE" if off_board? @start_coord
    @move_tree = Tree.new(@start_coord)
    # lineage = []

    winning_node = build_move_tree(end_square)

    # until winning_node.parent.nil?
    #   lineage << winning_node.value
    #   winning_node = winning_node.parent
    # end
    # lineage << @start_coord
    # lineage.reverse

    winning_node.path
  end

  def build_move_tree end_square
    visited_positions = [@start_coord]

    queue = [@move_tree.root]

    # begin interative part
    loop do
      working_node = queue.shift
      legit_moves = next_possible_moves(working_node.value).reject do |move|
        visited_positions.include?(move)
      end

      legit_moves.each do |legit_move|
        @move_tree.insert(working_node, legit_move, -1)
        visited_positions << legit_move
        queue << working_node.children[-1]

        #return winning node
        return working_node.children[-1] if legit_move == end_square
      end
    end
  end

  def next_possible_moves current
    steps = [1,2,-1,-2].permutation(2).to_a.reject do |combo|
      combo[0] + combo[1] == 0
    end

    moves = steps.map do |step|
      [step[0] + current[0], step[1] + current[1]]
    end.reject {|move| off_board?(move)}

    moves
  end

  def off_board? square
    square.any? {|coord| coord < 0 or coord > 7}
  end
end

nums = ARGV.join.split(/[,\[\]\s]/).reject {|el| el.empty?}.map {|n| n.to_i}
argv_arrays = []
nums.each_cons(2).with_index {|a, i| argv_arrays << a if i % 2 == 0}



startpoint = argv_arrays[0]
endpoints = *argv_arrays[1..-1]

p "Initializing KnightPathFinder, starting at #{startpoint}"

game = KnightPathFinder.new startpoint

p "Finding paths to the following destinations: #{endpoints}"
endpoints.each {|last_square| p game.find_path(last_square)}