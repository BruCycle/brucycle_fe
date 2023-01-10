class SafetyMailer < ApplicationMailer
  def safety_email(email)
    mail(to: email, subject: "Our records indicate you might be inebriated")
  end
end
