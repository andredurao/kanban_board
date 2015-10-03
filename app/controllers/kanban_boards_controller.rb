class KanbanBoardsController < ApplicationController
  before_action :set_kanban_board, only: [:show, :edit, :update, :destroy]

  # GET /kanban_boards
  # GET /kanban_boards.json
  def index
    @kanban_boards = user_signed_in? ? KanbanBoard.all : KanbanBoard.public_boards
  end

  # GET /kanban_boards/1
  # GET /kanban_boards/1.json
  def show
  end

  # GET /kanban_boards/new
  def new
    @kanban_board = KanbanBoard.new
  end

  # GET /kanban_boards/1/edit
  def edit
  end

  # POST /kanban_boards
  # POST /kanban_boards.json
  def create
    @kanban_board = KanbanBoard.new(kanban_board_params)

    respond_to do |format|
      if @kanban_board.save
        format.html { redirect_to @kanban_board, notice: 'Kanban board was successfully created.' }
        format.json { render :show, status: :created, location: @kanban_board }
      else
        format.html { render :new }
        format.json { render json: @kanban_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kanban_boards/1
  # PATCH/PUT /kanban_boards/1.json
  def update
    respond_to do |format|
      if @kanban_board.update(kanban_board_params)
        format.html { redirect_to @kanban_board, notice: 'Kanban board was successfully updated.' }
        format.json { render :show, status: :ok, location: @kanban_board }
      else
        format.html { render :edit }
        format.json { render json: @kanban_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kanban_boards/1
  # DELETE /kanban_boards/1.json
  def destroy
    @kanban_board.destroy
    respond_to do |format|
      format.html { redirect_to kanban_boards_url, notice: 'Kanban board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanban_board
      @kanban_board = KanbanBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kanban_board_params
      params.require(:kanban_board).permit(:title, :description, :public_visible)
    end
end
