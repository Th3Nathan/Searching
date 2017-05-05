require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  attr_accessor :start_position
  def initialize(start_position)
    @start_position = start_position
    @tree = PolyTreeNode.new(start_position)
    @previously_visited_spaces = []
    build_move_tree
  end

  def moves(pos = start_position)
    deltas = [[-2, -1], [-2, +1], [+2, -1], [+2, +1], [-1, -2], [-1, +2], [+1, -2], [+1, +2]]
    x, y = pos
    pos_moves = deltas.map { |a, b| [x + a, b + y] }
    return pos_moves.select do |a,b|
      a < 0 || b < 0 || a >= 7 || b >= 7 ? false : true
    end
  end

  def next_level
    moves.each do |move|
      node = PolyTreeNode.new(move)
      node.parent = @tree
      @tree.add_child(node)
    end
  end

  def create_trees(position)
    moves.next_level
  end

  def find_path(position)
    round = 0
    # while round < 8
    while true
      @tree.each do |node|
        moves(node.value).map do |pos|
          child = PolyTreeNode.new(pos)
          child.parent = node
          return find_parent(child) if child.value == position
          @tree << child
        end
      end
      # round += 1
    end
  end



  def find_parent(node)
    path = []
    until node.parent == nil
      path.unshift(node.value)
      node = node.parent
    end
    path.unshift(@start_position)
  end

  def search(target)
    @tree.first.bfs(target)
  end

  def build_move_tree(position = [0,0])
    #builds a move tree to be stored in an instance variable
    moves(position).reject do |move|
      @previously_visited_spaces.include?(move)
    end
  end

end
