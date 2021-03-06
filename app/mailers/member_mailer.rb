class MemberMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.account_activation.subject
  #
  def account_activation(member)
    @member = member
    mail to: member.email, subject: "MCamp! アカウントの有効にしてください。"
  end

  def password_reset(member)
    @member = member
    mail to: member.email,subject: "MCamp! パスワードをリセット"
  end



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.password_reset.subject
  #
end
