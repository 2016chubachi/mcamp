class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  class Forbidden < StandardError; end

   private
    def current_member
      Member.find_by(id: session[:member_id]) if session[:member_id]
    end
      helper_method :current_member

     def logged_in_member
       unless logged_in?
         store_location
         flash[:danger] = "ログインしてください。"
         redirect_to login_url
       end
     end


end
