module SessionsHelper
  def current_user
    if @current_user
      return @current_user
    else
      @current_user = User.find_by(id: session[:user_id])
    end
    
  end
  
  def login?
    if current_user
     return true
    else
     return false
    end
   
      
  end
      
    
    
end
