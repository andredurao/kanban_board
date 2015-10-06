require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should not save a task without a KanbanBoard" do
    task = Task.new
    assert_not task.save
    assert_includes task.errors.full_messages, "Kanban board can't be blank"
  end

  test "should not save a task without a title and current status" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new
    assert_not task.save
    assert_includes task.errors.full_messages, "Title can't be blank"
    assert_includes task.errors.full_messages, "Current status can't be blank"
    assert_includes task.errors.full_messages, "Priority can't be blank"
  end

  test "should not save a task with an invalid priority" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new(priority: "xxx")
    assert_not task.save
    assert_includes task.errors.full_messages, "Priority is not included in the list"
  end

  test "should not save a task with an invalid status" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new(current_status: "xxx")
    assert_not task.save
    assert_includes task.errors.full_messages, "Current status is not included in the list"
  end

  test "should save a task with an valid attributes" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new(current_status: "todo", priority: "low", title: "task test")
    assert task.save
    assert_equal task.position, 0
  end

  test "should increase positions on tasks" do
    board = KanbanBoard.new(title: "abc", description: "abcd")
    assert board.save
    task = board.tasks.new(current_status: "todo", priority: "low", title: "task test")
    assert task.save
    assert_equal task.position, 0

    task2 = board.tasks.new(current_status: "todo", priority: "high", title: "task test2")
    assert task2.save
    assert_equal task2.position, 1
  end
end
