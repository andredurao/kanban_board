class TasksController < ApplicationController
  before_action :set_kanban_board
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @kanban_board.tasks.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @kanban_board.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @kanban_board.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @kanban_board, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @kanban_board, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @kanban_board, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /tasks/update_positions.json
  def update_positions
    respond_to do |format|
      reply = {message: "success"}
      params[:positions].each_with_index do |task_id,i|
        @kanban_board.tasks.find(task_id).update_attribute(:position, i)
      end
      format.json { render json: reply, status: :ok }
    end
  end

  private
    def set_kanban_board
      @kanban_board = KanbanBoard.find(params[:kanban_board_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:kanban_board_id, :title, :priority, :current_status, :deleted, :hidden)
    end
end
