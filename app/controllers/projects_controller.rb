class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :delete_attachment]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "案件を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @project = Project.find(params[:id])
  
    Rails.logger.debug "削除対象の添付ファイル: #{params[:delete_attachments].inspect}" # ログ出力で確認
  
    # 添付ファイルの削除処理
    if params[:delete_attachments].present?
      params[:delete_attachments].each do |attachment_id|
        @project.attachments.find(attachment_id).purge
      end
    end
  
    # 添付ファイルの追加処理
    @project.attachments.attach(project_params[:attachments]) if project_params[:attachments].present?
  
    if @project.update(project_params.except(:attachments))
      redirect_to @project, notice: "案件情報を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
  
    begin
      @project.attachments.each(&:purge) if @project.attachments.attached? # 添付ファイルを削除
      @project.destroy! # 例外を発生させることで、エラーハンドリングを適用
      redirect_to projects_path, notice: "案件を削除しました！"
    rescue ActiveRecord::RecordNotDestroyed => e
      Rails.logger.error "削除に失敗しました: #{e.message}"
      redirect_to project_path(@project), alert: "案件の削除に失敗しました。"
    end
  end

  def delete_attachment
    attachment = @project.attachments.find(params[:attachment_id])
    attachment.purge # 特定のファイルを削除
    redirect_to edit_project_path(@project), notice: "添付ファイルを削除しました！"
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:customer_name, :sales_office, :sales_representative, :request_type, :request_content, :order_date, :due_date, :revenue, :cost, :remarks, attachments: [])
  end
end