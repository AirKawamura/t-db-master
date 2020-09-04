class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_role, only: [:create, :update]

  def index
    @users = current_company.users
  end

  def show
  end

  def new
    @user = current_company.users.build
  end

  def edit
  end

  def create
    @user = current_company.users.build(user_params)

    if @user.save
      redirect_to admin_users_url, notice: "ユーザーを登録しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: "保存しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザーを削除しました"
  end

  private
  
    def verify_authorized
      authorize [:admin, :user]
    end

    def set_user
      @user = current_company.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
    end

    def check_role
      # 不正リクエスト対策
      unless %w(member manager admin).include?(user_params[:role])
        redirect_to admin_users_url, alert: "不明なエラーが発生しました"
      end
    end
end
