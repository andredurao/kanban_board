require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should not save a task without a KanbanBoard" do
    task = Task.new
    task.valid?
    assert_includes task.errors.full_messages, "Kanban board can't be blank"
    # "Title can't be blank", "Current status can't be blank"]
  end

  test "should not save a task without a title and current status" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new
    task.valid?
    assert_includes task.errors.full_messages, "Title can't be blank"
    assert_includes task.errors.full_messages, "Current status can't be blank"
  end
end
