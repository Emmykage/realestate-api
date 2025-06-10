class TransactionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.transaction_mailer.send_notification.subject
  #
  def send_notification(user, transaction)
    @greeting = "Hi"
    @user = user
    @transaction = transaction

    mail(to: user.email,
     subject: "Transaction Initialized - BitBridge Global"
    )
  end

    def confirm_transaction(user, transaction)
    @user = user
    @transaction = transaction



    binding.b


    mail(to: [user.email, default_to],
     subject: "Transaction Confirmation - BitBridge Global"
    )
  end
end
