class KanbanBoard < ActiveRecord::Base  
  DEFAULT_COLUMNS = %i(todo in_progress to_verify done)

  # Associations
  has_many :tasks

  # Scopes

  # Validations
  validates :title, :description, presence: true

  # private

  # public

  def default_columns
    DEFAULT_COLUMNS
  end

end
