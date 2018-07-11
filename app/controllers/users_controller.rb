class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]
  before_action :require_correct_user, only: [ :edit, :update, :destroy]
  
  
  
  def show
    @user = User.find(params[:id])
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "新規登録が完了しました"
      redirect_to @user
    else
      flash.now[:danger] = "失敗しました"
      render :new
    end

  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "プロフィール更新が完了しました"
      redirect_to @user
    else
      flash.now[:danger] = "失敗しました"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def require_correct_user
    unless User.find(params[:id]) == current_user
      redirect_to root_path
    end
  end
  
    
  
  
  
  
end
