require 'faker'

def email
  Faker::Internet.email
end

def password
  Faker::Internet.password(6)
end

def title
  Faker::Lorem.word
end

def body
  Faker::Lorem.sentence
end

def user
  user = User.new(email: email, password: password, nickname: title)
  user.skip_confirmation!
  user.save!
  user
end

def question
  Question.create(title: title, body: body, user: user)
end

def answer
  Answer.create(body: body, question: question, user: user, best_answer: best_answer)
end

def best_answer
  Faker::Boolean.boolean
end

15.times { Attachment.create(file: File.open(File.join(Rails.root, '/public/favicon.ico')), attachable: question) }
15.times { Attachment.create(file: File.open(File.join(Rails.root, '/public/favicon.ico')), attachable: answer) }
