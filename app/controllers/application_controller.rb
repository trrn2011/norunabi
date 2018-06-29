class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def require_login
    unless login?
      redirect_to login_path
    end
  end
  
  
    
      

      
end
