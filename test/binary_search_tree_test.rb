require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'
require './lib/node'

class BinarySearchTreeTest < Minitest::Test
  def test_it_starts_with_head_equal_to_nil
    tree = BinarySearchTree.new

    assert_nil tree.head
  end

  def test_first_node_becomes_head
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")

    result = tree.head

    assert_equal 61, result.score
  end

  def test_it_traverses_tree_and_inserts_nodes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress, Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    result1 = tree.head.left.score
    result2 = tree.head.right.score
    result3 = tree.head.left.right.score
    result4 = tree.head.left.right.left.score

    assert_equal 16, result1
    assert_equal 92, result2
    assert_equal 50, result3
    assert_equal 42, result4
  end

  def test_insert_returns_new_node_depth
    tree = BinarySearchTree.new
    result1 = tree.insert(61, "Bill & Ted's Excellent Adventure")
    result2 = tree.insert(16, "Johnny English")
    result3 = tree.insert(92, "Sharknado 3")
    result4 = tree.insert(50, "Hannibal Buress, Animal Furnace")

    assert_equal 0, result1
    assert_equal 1, result2
    assert_equal 1, result3
    assert_equal 2, result4
  end

  def test_it_verifies_or_rejects_the_presence_of_a_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress, Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    assert tree.include?(92)
    assert tree.include?(42)
    assert tree.include?(50)
    refute tree.include?(88)
    refute tree.include?(76)
  end

  def test_it_reports_the_depth_of_tree_where_score_appears
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress, Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    assert_equal 0, tree.depth_of(61)
    assert_equal 1, tree.depth_of(16)
    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
    assert_equal 3, tree.depth_of(42)
  end

  def test_it_returns_the_movie_with_the_highest_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress, Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    assert_equal ({"Sharknado 3"=>92}), tree.max
  end

  def test_it_returns_the_movie_with_the_lowest_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress, Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    assert_equal ({"Johnny English"=>16}), tree.min
  end

  def test_it_returns_an_array_of_all_movies_and_scores_sorted_in_ascending_order
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    expected = [ ({"Johnny English"=>16}),
                        ({"The Breakfast Club"=>42}),
                        ({"Hannibal Buress: Animal Furnace"=>50}),
                        ({"Bill & Ted's Excellent Adventure"=>61}),
                        ({"Sharknado 3"=>92})]
    expected_scores = [16, 42, 50, 61, 92]

    assert_equal expected, tree.sort
  end

  def test_it_loads_a_file_of_movies_and_inserts_each_into_tree
    tree = BinarySearchTree.new
    tree.load('./data/movies.txt')

    expected1 = ({"The Godfather"=>47})
    expected2 = ({"A Streetcar Named Desire"=>0})
    expected3 = ({"The Silence of the Lambs"=>100})

    assert_equal expected1, tree.head.data
    assert_equal expected2, tree.min
    assert_equal expected3, tree.max
  end

  def test_load_replaces_movies_already_in_tree_with_those_in_file
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(42, "The Breakfast Club")
    tree.load('./data/movies.txt')

    expected1 = ({"The Godfather"=>47})
    expected2 = ({"The Shawshank Redemption"=>88})
    expected3 = ({"Citizen Kane"=>9})


    assert_equal expected1, tree.head.data
    assert_equal expected2, tree.head.right.data
    assert_equal expected3, tree.head.left.data
  end

  def test_loading_file_returns_total_number_of_movies_inserted_into_tree
    tree = BinarySearchTree.new

    number_of_movies = tree.load('./data/movies.txt')

    assert_equal 100, number_of_movies
  end

  def test_it_sorts_all_movies_and_scores_in_tree_in_ascending_order
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(42, "The Breakfast Club")

    expected = [  ({"Johnny English"=>16}),
                  ({"The Breakfast Club"=>42}),
                  ({"Hannibal Buress: Animal Furnace"=>50}),
                  ({"Bill & Ted's Excellent Adventure"=>61}),
                  ({"Sharknado 3"=>92})
                ]

    assert_equal expected, tree.sort
  end
end
