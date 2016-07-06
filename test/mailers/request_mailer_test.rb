require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  test "accept_request" do
    mail = RequestMailer.accept_request
    assert_equal "Accept request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "refuse_request" do
    mail = RequestMailer.refuse_request
    assert_equal "Refuse request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
