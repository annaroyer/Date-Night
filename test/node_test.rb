require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_it_accepts_data
    node = Node.new({"Bill and Ted's Excellent Adventure"=>61})

    result = node.data

    assert_equal ["Bill and Ted's Excellent Adventure"], result.keys
    assert_equal [61], result.values
  end

  def test_left_and_right_nodes_start_nil
    node = Node.new({"Bill and Ted's Excellent Adventure"=>61})

    assert_nil node.left
    assert_nil node.right
  end

  def test_it_can_extract_the_movie_score_from_its_data
    node = Node.new({"Bill and Ted's Excellent Adventure"=>61})

    assert_equal 61, node.score
  end

  def test_it_can_add_a_new_node_to_left_or_right
    node = Node.new({"Bill and Ted's Excellent Adventure"=>61})
    node2 = Node.new({"Johnny English"=>16})
    node3 = Node.new({"Sharknado 3"=>92})
    node.add(node2)
    node.add(node3)

    assert_equal node2, node.left
    assert_equal node3, node.right
  end

  def test_it_takes_a_node_and_decides_to_send_it_left_or_right
    node1 = Node.new({"Bill and Ted's Excellent Adventure"=>61})
    node2 = Node.new({"Johnny English"=>16})
    node3 = Node.new({"Sharknado 3"=>92})
    node4 = Node.new({"Hannibal Burress: Animal Furnace"=>50})
    node1.left = node2
    node1.right = node3

    result = node1.next_node(50)

    assert_equal node2, result
  end
end
