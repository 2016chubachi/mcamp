class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  class Forbidden < StandardError; end

  # use for other loan and borrow.
   private
    def current_member
      Member.find_by(id: session[:member_id]) if session[:member_id]
    end
      helper_method :current_member

    def logged_in_member
      unless logged_in?
       store_location
       flash.now[:alert] = "ログインしてください。"
       redirect_to login_url
      end
    end

    def correct_item_member
      @member = Member.find(LoanItem.find(params[:id]).member_id)
      # render text: @member.user_name
      redirect_to(root_url) unless current_member?(@member)
    end

    def admin_member
     redirect_to(root_url) unless current_member.admin?
    end

    def  correct_rec_request_member
      redirect_to(root_url) unless current_member.id == Request.find(params[:id]).loan_item.member_id
    end
end
