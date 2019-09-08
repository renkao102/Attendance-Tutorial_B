class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def index
  # 初期表示  
  def index
    @users = User.all
    # パラメータとして名前を受け取っている場合は絞って検索する
  if params[:name].present?
    @users = @users.get_by_name params[:name]
  end
    
    # データを閲覧する画面を表示するためのAction
  def show
    @user = User.find(params[:id])
    
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
    
    # データを作成する画面を表示するためのAction
  def new
    @user = User.new
  end
    
    # データを更新する画面を表示するためのAction
  def edit
    @user = User.find(params[:id])
  end
    
    # データを作成するためのAction
  def create
    @user = User.new(user_params)
    @user.save
    redirect_to @user

  if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
  else
      render :new
      redirect_to @user and return
  end
  end
    
    # データを更新するためのAction
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to @user
    
  if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
  else
      render :edit      
  end
  end
  end
  
    # データを削除するためのAction
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
    
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
 
  def edit_basic_info
  end

  def update_basic_info
  if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
  else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
  end
  end
      redirect_to users_url
  end

  
  def user_params
    params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
  end

  def basic_info_params
    params.require(:user).permit(:department, :basic_time, :work_time)
  end
end
