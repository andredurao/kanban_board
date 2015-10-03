json.array!(@kanban_boards) do |kanban_board|
  json.extract! kanban_board, :id, :title, :description, :public_visible
  json.url kanban_board_url(kanban_board, format: :json)
end
