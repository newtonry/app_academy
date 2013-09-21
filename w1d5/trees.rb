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

  def children?
    [@left, @right].compact.empty?
  end
end

tree = Tree.new(1)
tree.insert(tree.root, 2, 0)
tree.insert(tree.root, 3, 1)

tree.insert(tree.root.children[0], 4, 0)
tree.insert(tree.root.children[0], 5, 1)
tree.insert(tree.root.children[0], 8, 2)


tree.insert(tree.root.children[1], 6, 0)
tree.insert(tree.root.children[1], 7, 1)

 p tree.print_tree(tree.root)

#p tree.dfs(6).value
puts "BFS(6) is #{tree.bfs(6).value}"
puts "BFS with { |elt| elt % 5 == 0 } is #{tree.bfs { |elt| elt.value % 5 == 0}.value }"

puts 'DFS!'
# dfs_found_node = tree.dfs(6)
puts "DFS(6) is #{tree.dfs(6).value}"
puts "tree.dfs(45) is #{tree.dfs(45).to_s}"

puts 'DFS_with { |elt| elt % 7 == 0 }'
p tree.dfs { |elt| elt.value % 5 == 15 }.class

puts "bfs 4 is #{tree.bfs(4).value}"