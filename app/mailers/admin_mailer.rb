# encoding: utf-8

class AdminMailer < ActionMailer::Base
  default from: "contact@palava.tv"
  default to: "contact@palava.tv"


  def new_feedback(feedback_entry)
    @feedback_entry = feedback_entry
    mail(
      subject: "palava-admin | New Feedback",
    )
  end
end
