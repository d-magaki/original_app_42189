class TasksController < ApplicationController
  def index
    @tasks = Project.all.map do |project|
      Task.new(
        customer_name: project.customer_name,
        order_date: project.order_date,
        due_date: project.due_date,
        request_type: Project::REQUEST_TYPES.key(project.request_type) || "未設定", # 🔹 数値を文字列化
        request_content: Project::REQUEST_CONTENTS.key(project.request_content) || "未設定",
        attachment: project.attachments,
        notes: project.remarks,
        status: project.status || "未着手"
      )
    end
  end

  def show
    project = Project.find(params[:id])
    @task = Task.new(
      customer_name: project.customer_name,
      order_date: project.order_date,
      due_date: project.due_date,
      request_type: project.request_type,
      request_content: project.request_content,
      attachment: project.attachments.map(&:url), # 🔹 修正点
      notes: project.remarks,
      status: project.status || "未対応"
    )
  end
end