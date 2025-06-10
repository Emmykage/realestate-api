class ApplicationMailer < ActionMailer::Base
  default from: "support@phoenixprecastltd.com"
  def default_to
     "info@phoenixprecastltd.com"
  end
  layout "mailer"
end
