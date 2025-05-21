require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "transaction_deposit" do
    mail = NotificationMailer.transaction_deposit
    assert_equal "Transaction deposit", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
