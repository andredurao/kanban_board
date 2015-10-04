class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :kanban_board, index: true
      t.string :title
      t.string :priority
      t.string :current_status
      t.boolean :deleted, default: false
      t.boolean :hidden, default: false

      t.timestamps null: false
    end
    add_foreign_key :tasks, :kanban_boards
  end
end
