class Task
  include ActiveModel::Model

  attr_accessor :customer_name, :order_date, :due_date, :request_type, :request_content, :attachment, :notes, :status
end