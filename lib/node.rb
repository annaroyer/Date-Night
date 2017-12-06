require 'pry'
class Node
  attr_reader :data

  attr_accessor :left,
                :right,
                :depth

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
    @depth = 0
    @sorted = false
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

  def find_depth(depth)
      if @depth == depth
        data
      else
        [@left, @right].map do |node|
          node.find_depth(depth) unless node.nil?
        end.flatten.compact
      end
  end
end

binding.pry
