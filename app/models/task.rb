class Task < ActiveRecord::Base
  DEFAULT_PRIORITIES = %i(low regular medium high critical)

  # Associations
  belongs_to :kanban_board

  # Scopes

  # Validations
  validates :kanban_board_id, :title, :current_status, presence: true

  # private

  # public

  def default_priorities
    DEFAULT_PRIORITIES
  end


end
