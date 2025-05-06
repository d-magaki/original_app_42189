class Task
  include ActiveModel::Model

  attr_accessor :task_id, :customer_name, :order_date, :due_date, :request_type, :request_content,
                :attachment, :notes, :status, :department_name, :assigned_person, :employee_id, :start_date, :end_date
end