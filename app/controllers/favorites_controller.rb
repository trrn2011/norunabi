class FavoritesController < ApplicationController
  before_action :require_login
  
  def create
    @post = Post.find(params[:post_id])
    if current_user.fav(@post)
    flash[:success] = "いいねしました"
    
    end
    redirect_back(fallback_location: user_path(current_user))
  
  end

 
end
