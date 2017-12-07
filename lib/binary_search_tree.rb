require './lib/node'
require 'pry'
class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
    @total = 0
  end

  def insert(score, movie)
    @total += 1
    node = Node.new({movie=>score})
    if @head.nil?
      @head = node
    else
      @head.push(node)
    end
    node.depth
  end

  def include?(score, node=@head, found=true)
    until node.nil?
      return found if node.score == score
      node = node.next_node(score)
    end
    !found
  end

  def depth_of(score, node=@head, depth=0)
    until node.nil?
      return node.depth if node.score == score
      node = node.next_node(score)
    end
  end

  def max(node=@head)
    until node.right.nil?
      node = node.right
    end
    node.data
  end

  def min(node=@head)
    until node.left.nil?
      node = node.left
    end
    node.data
  end

  def sort
    subtrees = @head.sort
    subtrees.flatten.compact
  end

  def load(file)
    @head = nil
    File.open(file, 'r').each_with_index do |movie, index|
      data = movie.split(', ')
      score = data.first.to_i
      title = data.last.chomp
      insert(score, title)
    end
    return @total
  end

  def health(depth)
    @head.nodes_at_depth(depth).map do |node|
      children = node.children + 1
      percent = (children * 100)/@total
      [node.score, children, percent]
    end
  end
end
binding.pry
