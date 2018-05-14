class DigestJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      pp DailyMailer.digest(user)
      DailyMailer.digest(user).deliver_now
    end
  end
end
