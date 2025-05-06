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
  
    # 🔹 `employee_id` でも `users` テーブルを検索できるように修正
    user = User.find_by(employee_id: project.user_id) || User.find_by(employee_id: project.assigned_person) # 🔹 修正
  
    @task = Task.new(
      task_id: project.id,
      customer_name: project.customer_name,
      order_date: project.order_date,
      due_date: project.due_date,
      request_type: Project::REQUEST_TYPES.key(project.request_type) || "未設定",
      request_content: Project::REQUEST_CONTENTS.key(project.request_content) || "未設定",
      status: nil,
      department_name: user&.department || "未設定",
      assigned_person: user&.user_name || "未設定",
      employee_id: user&.employee_id || "未設定",
      start_date: project.planning_start_date || "未設定",
      end_date: project.development_end_date || "未設定",
      attachment: project.attachments,
      notes: project.remarks
    )
  end

  def edit
    project = Project.find(params[:id])
    user = User.find_by(employee_id: project.user_id)

    @task = Task.new(
      task_id: project.id,
      customer_name: project.customer_name,
      order_date: project.order_date,
      due_date: project.due_date,
      request_type: Project.request_types.key(project.request_type) || "未設定",
      request_content: Project.request_contents.key(project.request_content) || "未設定",
      status: Project.statuses.key(project.status) || "未着手", # 🔹 修正
      department_name: user&.department || "未設定",
      assigned_person: user&.user_name || "未設定",
      employee_id: user&.employee_id || "未設定",
      planning_start_date: project.planning_start_date || "未設定",
      planning_end_date: project.planning_end_date || "未設定",
      design_start_date: project.design_start_date || "未設定",
      design_end_date: project.design_end_date || "未設定",
      development_start_date: project.development_start_date || "未設定",
      development_end_date: project.development_end_date || "未設定",
      notes: project.remarks,
      attachment: project.attachments
    )
  end

  def update
    project = Project.find(params[:id])
  
    # 🔹 添付資料の削除処理
    if params[:delete_attachments].present?
      params[:delete_attachments].each do |attachment_id|
        project.attachments.find(attachment_id).purge
      end
    end
  
    # 🔹 社員情報を `users` テーブルから取得
    user = User.find_by(employee_id: params[:task][:employee_id])
  
    # 🔹 添付資料の保持
    updated_params = task_params
    updated_params[:attachments] ||= project.attachments if params[:task][:attachments].blank?
  
    # 🔹 `update` では `employee_id`・`assigned_person`・`department_name` を渡さないよう修正
    if project.update(updated_params.except(:employee_id, :assigned_person, :department_name))
      redirect_to task_path(project.id), notice: "タスクが更新されました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end
  
  private
  
  def task_params
    params.require(:task).permit(
      :status,
      :remarks, # 🔹 `notes` ではなく `remarks` を適用
      :planning_start_date, :planning_end_date,
      :design_start_date, :design_end_date,
      :development_start_date, :development_end_date,
      attachments: []
    )
  end
end