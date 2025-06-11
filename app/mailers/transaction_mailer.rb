class TransactionMailer < ApplicationMailer
  default_to = "support@phoenixprecastltd.com"
  def send_notification(user, transaction)
    @user = user
    attachments.inline['logo.jpg'] = File.read(Rails.root.join('app/assets/images/logo.jpg'))

    @transaction = transaction

    mail(to: [user.email, default_to],
    subject: "Transaction Initialized - Phoenix Precast"
    )
  end

    def confirm_transaction(user, transaction)
    @user = user
    @transaction = transaction

    mail(to: [user.email, default_to],
     subject: "Transaction Confirmation - Phoenix Precast"
    )
  end
end
