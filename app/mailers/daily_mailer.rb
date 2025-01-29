class DailyMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where('created_at >= ?', 1.day.ago)

    mail(to: user.email, subject: 'Digest')
  end
end
