class AnswersChannel < ApplicationCable::Channel
  def follow(params)
    pp params['id']
    stream_from "questions/#{params['id']}/answers"
  end
end