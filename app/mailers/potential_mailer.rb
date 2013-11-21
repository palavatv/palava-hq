# encoding: utf-8

class PotentialMailer < ActionMailer::Base
  default from: "contact@palava.tv"


  def welcome(potential)
    @potential     = potential
    @no_unsubscribe = true
    mail(
      to: @potential.email,
      subject: "palava | Thank you for subscribing",
    )
  end
end
