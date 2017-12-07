
class Node
  attr_reader :data,
              :children

  attr_accessor :left,
                :right,
                :depth

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
    @depth = 0
    @children = 0
  end

  def score
    return @data.values.first
  end

  def next_node(new_score)
    if new_score < score
      return @left
    else
      return @right
    end
  end

  def push(node)
    @children += 1
    node.depth += 1
    if next_node(node.score).nil?
      add(node)
    else
      next_node(node.score).push(node)
    end
  end

  def add(node)
    if node.score < score
      @left = node
    elsif node.score > score
      @right = node
    end
  end

  def sort
    [@left, data, @right].map do |data|
      if data.class == Node
        data.sort
      else
        data
      end
    end
  end

  def nodes_at_depth(depth)
    if @depth == depth
      [self]
    else
      [@left, @right].compact.map do |node|
        node.nodes_at_depth(depth)
      end.flatten
    end
  end
end
