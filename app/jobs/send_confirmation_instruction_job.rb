class SendConfirmationInstructionJob < ApplicationJob
    # Your job implementation goes here
    queue_as :default

    def perform(user)

      UserMailer.confirmation_email(user).deliver_now

      
    end
  end