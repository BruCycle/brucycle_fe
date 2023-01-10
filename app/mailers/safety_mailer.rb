class SafetyMailer < ApplicationMailer
  def safety_email 
    mail(to: 'smculliton@gmail.com', subject: "Our records indicate you might be inebriated")
  end
end
