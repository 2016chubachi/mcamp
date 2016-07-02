class RequestMailer < ApplicationMailer

  def accept_request(request)
    @request = request
    mail to: request.member.email, subject: "MCamp! リクエスト承認通知"
  end

  def refuse_request(request)
    @request = request
    mail to: request.member.email, subject: "MCamp! リクエスト拒否通知"
  end
  
end
