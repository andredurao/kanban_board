class Task < ActiveRecord::Base
  DEFAULT_PRIORITIES = %w(low regular medium high critical)

  # Associations
  belongs_to :kanban_board

  # Scopes
  scope :of_status, ->(status) { where("current_status = ?", status) }

  # Validations
  validates :kanban_board_id, :title, :current_status, :priority, presence: true
  validates :priority, inclusion: { in: DEFAULT_PRIORITIES }
  validates :current_status, inclusion: { in: KanbanBoard::DEFAULT_COLUMNS}

  # private

  # public

  def default_priorities
    DEFAULT_PRIORITIES
  end


end
