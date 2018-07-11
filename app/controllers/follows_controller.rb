class FollowsController < ApplicationController
  before_action :require_login
  
  def create
    @line = Line.find(params[:line_id])
    if current_user.follow(@line)
    flash[:success] = "お気に入り登録しました"
    
    end
    redirect_back(fallback_location: user_path(current_user))
  
  end

  def destroy
    @line = Line.find(params[:line_id])
    if current_user.unfollow(@line)
      flash[:success] = "お気に入り解除しました"
      
    end
    redirect_back(fallback_location: user_path(current_user))
  end
end
