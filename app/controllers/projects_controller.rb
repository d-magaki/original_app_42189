class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "案件を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:customer_name, :sales_office, :sales_representative, :request_type, :request_content, :order_date, :due_date, :revenue, :cost, :remarks, attachments: [])
  end
end
