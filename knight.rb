require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  attr_accessor :start_position, :root_node
  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]
    @root_node = nil
    build_move_tree
  end

  def new_move_positions(pos)
    valid_surrounding_positions = KnightPathFinder.valid_moves(pos).reject do |e|
      @visited_positions.include?(e)
     end
    @visited_positions += valid_surrounding_positions
    return valid_surrounding_positions
  end

  def self.valid_moves(position)
    deltas = [[-2, -1], [-2, +1], [+2, -1], [+2, +1], [-1, -2], [-1, +2], [+1, -2], [+1, +2]]
    x, y = position
    pos_moves = deltas.map { |a, b| [x + a, b + y] }
    return pos_moves.select do |a,b|
      a < 0 || b < 0 || a >= 7 || b >= 7 ? false : true
    end
  end

  def find_path(end_position)
    trace_back_path(@root_node.bfs(end_position))
  end


  def trace_back_path(node)
    path = []
    until node.parent == nil
      path.unshift(node.value)
      node = node.parent
    end
    path
  end


  def build_move_tree(position = [0,0])
    #builds a move tree to be stored in an instance variable
    @root_node = PolyTreeNode.new(position)
    queue = [@root_node]
    until queue.empty?
      parent = queue.shift
      parent_position = parent.value
      unvisited_surrounding_positions = new_move_positions(parent_position)
      unvisited_surrounding_positions.each do |pos|
        child_node = PolyTreeNode.new(pos)
        child_node.parent = parent
        queue << child_node
      end
    end
  end

end
