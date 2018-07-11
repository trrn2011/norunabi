class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]
  before_action :require_correct_user, only: [ :edit, :update, :destroy]
  
  
  
  def show
    @user = User.find(params[:id])
    @count_fav = @user.count_fav
    @rank = user_rank(@user)
    
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
  
  def user_rank(user)
    fav_rank = {}
    User.all.each do |usr|
      fav = usr.count_fav
      id = usr.id
      fav_rank["#{id}"] = fav
    end
    @fav_rank = fav_rank.sort_by {|k, v| -v}
    @fav_ranking = {}
    i = 0
    @fav_rank.each do |block|
      i = i+1
      id = block[0]
      @fav_ranking["#{id}"] = i
    end
    
    key = user.id
    
    return @fav_ranking["#{key}"]
    
  end
  
    
  
  
  
  
end
