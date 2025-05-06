class Task
  include ActiveModel::Model

  attr_accessor :task_id, :customer_name, :order_date, :due_date, :request_type, :request_content,
                :attachment, :notes, :status, :department_name, :assigned_person, :employee_id,
                :planning_start_date, :planning_end_date, :design_start_date, :design_end_date,
                :development_start_date, :development_end_date, :start_date, :end_date # 🔹 `end_date` も追加
end