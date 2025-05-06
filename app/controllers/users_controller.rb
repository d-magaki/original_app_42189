class UsersController < ApplicationController 
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, alert: "ユーザーを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:employee_id, :user_name, :department, :email)
  end
end