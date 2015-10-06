class Task < ActiveRecord::Base
  DEFAULT_PRIORITIES = %w(low regular medium high critical)

  # Associations
  belongs_to :kanban_board

  # Scopes
  scope :of_status, ->(status) { where("current_status = ?", status).order(:position) }

  # Validations
  validates :kanban_board_id, :title, :current_status, :priority, presence: true
  validates :priority, inclusion: { in: DEFAULT_PRIORITIES }
  validates :current_status, inclusion: { in: KanbanBoard::DEFAULT_COLUMNS}

  # Callbacks
  before_create :set_initial_position

  # public

  def default_priorities
    DEFAULT_PRIORITIES
  end

  private
    def set_initial_position
      status_siblings = kanban_board.tasks.of_status(self.current_status).order(:position)
       if status_siblings.present?
         self.position = status_siblings.last.position + 1
       else
         self.position = 0
       end
    end
end
