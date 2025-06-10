require "test_helper"

class TransactionMailerTest < ActionMailer::TestCase
  test "send_notification" do
    mail = TransactionMailer.send_notification
    assert_equal "Send notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
