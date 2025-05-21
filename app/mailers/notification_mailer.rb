class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.transaction_deposit.subject
  #
  def transaction_deposit(user, trasaction)
    # from: "support@phoenixprecastltd.com"
    @greeting = "Hi"
    @user = user
    @transaction = transaction

    mail(to: @user.email, subject: "Deposit Confirmation")
  end
end
