module TasksHelper
  PRIORITIES_X_REF =
    {
      :low => "success",
      :regular => "primary",
      :medium => "default",
      :high => "warning",
      :critical => "danger"
   }

  def task_class_by_priority(priority)
    PRIORITIES_X_REF[priority.to_sym]
  end 
end
