class CreateKanbanBoards < ActiveRecord::Migration
  def change
    create_table :kanban_boards do |t|
      t.string :title
      t.string :description
      t.boolean :public_visible, default: true

      t.timestamps null: false
    end
  end
end
