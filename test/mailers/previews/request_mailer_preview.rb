# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/accept_request
  def accept_request
    request = Request.first
    RequestMailer.accept_request(request)
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/refuse_request
  def refuse_request
    request = Request.first
    RequestMailer.refuse_request(request)
  end

end
