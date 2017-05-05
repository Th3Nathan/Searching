class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children
  def initialize(val)
    @value = val
    @parent = nil
    @children = []
  end


  def parent=(new_parent)
    return @parent = new_parent if new_parent == nil
    parent.children.delete(self) if @parent
    new_parent.children << self unless new_parent.children.include?(self)
    @parent = new_parent
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "no a child " unless self.children.include?(child)
    child.parent = nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      first_node = queue.shift
      return first_node if first_node.value == target
      queue += first_node.children
    end
    nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result if search_result
    end
    nil
  end

end


node1 = PolyTreeNode.new(1)
node2 = PolyTreeNode.new(2)
node3 = PolyTreeNode.new(3)
