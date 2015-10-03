json.array!(@tasks) do |task|
  json.extract! task, :id, :kanban_board_id, :title, :priority, :current_status, :deleted, :hidden
  json.url task_url(task, format: :json)
end
