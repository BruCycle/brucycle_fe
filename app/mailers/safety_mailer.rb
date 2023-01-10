class SafetyMailer < ApplicationMailer
  def safety_email
    user = params[:user]
    mail(to: user.email, subject: "Our records indicate you might be inebriated")
  end
end
