require 'test_helper'

class KanbanBoardTest < ActiveSupport::TestCase
  test "should not save a board without title and description" do
    board = KanbanBoard.new
    assert_not board.save
  end
  test "should not save a board without title" do
    board = KanbanBoard.new(description: "abc")
    assert_not board.save
  end
  test "should not save a board without description" do
    board = KanbanBoard.new(title: "abc")
    assert_not board.save
  end
  test "should save a board with title and description" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
  end
end
