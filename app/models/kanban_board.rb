class KanbanBoard < ActiveRecord::Base
  DEFAULT_COLUMNS = %w(todo in_progress to_verify done)

  # Associations
  has_many :tasks

  # Scopes
  scope :public_boards,  -> { where(public_visible: true) }
  scope :private_boards, -> { where(public_visible: false) }

  # Validations
  validates :title, :description, presence: true

  # private

  # public

  def default_columns
    DEFAULT_COLUMNS
  end

end
