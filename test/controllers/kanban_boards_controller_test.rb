require 'test_helper'

class KanbanBoardsControllerTest < ActionController::TestCase
  setup do
    @kanban_board = kanban_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kanban_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kanban_board" do
    assert_difference('KanbanBoard.count') do
      post :create, kanban_board: { description: @kanban_board.description, public_visible: @kanban_board.public_visible, title: @kanban_board.title }
    end

    assert_redirected_to kanban_board_path(assigns(:kanban_board))
  end

  test "should show kanban_board" do
    get :show, id: @kanban_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kanban_board
    assert_response :success
  end

  test "should update kanban_board" do
    patch :update, id: @kanban_board, kanban_board: { description: @kanban_board.description, public_visible: @kanban_board.public_visible, title: @kanban_board.title }
    assert_redirected_to kanban_board_path(assigns(:kanban_board))
  end

  test "should destroy kanban_board" do
    assert_difference('KanbanBoard.count', -1) do
      delete :destroy, id: @kanban_board
    end

    assert_redirected_to kanban_boards_path
  end
end
