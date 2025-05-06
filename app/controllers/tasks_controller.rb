class TasksController < ApplicationController
  def index
    @tasks = Project.all.map do |project|
      Task.new(
        task_id: project.id,
        customer_name: project.customer_name,
        order_date: project.order_date,
        due_date: project.due_date,
        request_type: Project::REQUEST_TYPES.key(project.request_type) || "未設定", # 🔹 数値を文字列化
        request_content: Project::REQUEST_CONTENTS.key(project.request_content) || "未設定",
        attachment: project.attachments,
        notes: project.remarks,
        status: nil
      )
    end
  end

  def show
    project = Project.find(params[:id])
    user = User.find_by(employee_id: project.user_id) # 🔹 社員情報を取得

    @task = Task.new(
      task_id: project.id,
      customer_name: project.customer_name,
      order_date: project.order_date,
      due_date: project.due_date,
      request_type: Project::REQUEST_TYPES.key(project.request_type) || "未設定",
      request_content: Project::REQUEST_CONTENTS.key(project.request_content) || "未設定",
      status: nil, # 🔹 一覧 (`index`) と統一
      department_name: user&.department || "未設定",
      assigned_person: user&.user_name || "未設定",
      employee_id: user&.employee_id || "未設定",
      start_date: project.planning_start_date || "未設定",
      end_date: project.development_end_date || "未設定",
      attachment: project.attachments,
      notes: project.remarks
    )
  end
end



