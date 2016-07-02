class SessionsController < ApplicationController

  def new
  end

  def create
    member = Member.find_by(email: params[:session][:email].downcase)
    if member && member.authenticate(params[:session][:password])
      if member.activated?
       log_in member
       params[:session][:remember_me] == '1' ? remember(member) : forget(member)
       redirect_back_or root_url
      else
        message  = "アカウントが有効になっておりません。 "
        message += "アカウントを有効にするメールを登録なさったメールに送りました。"
        flash[:alert] = message
        redirect_to root_url
　　   end
    else
      flash.now[:alert] = '名前とパスワードが一致しません。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
