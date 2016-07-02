class AccountActivationsController < ApplicationController
  # account activation.
  def edit
    member = Member.find_by(email: params[:email])
    if member && !member.activated? && member.authenticated?(:activation, params[:id])
       member.activate
      log_in member
      flash.now[:notice] = "アカウントが有効化されました。!"
      redirect_to member
    else
      flash.now[:alert] = "無効なリンクです。"
      redirect_to root_url
    end
  end
end
