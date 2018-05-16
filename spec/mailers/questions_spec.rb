require "rails_helper"

RSpec.describe QuestionsMailer, type: :mailer do
  describe "new_answer" do
    let(:user) { create :user }
    let(:new_user) { create :user }
    let!(:question) { create :question, user: user }
    let!(:answer) { create :answer, question: question, user: new_user }
    let!(:mail) { QuestionsMailer.new_answer(question, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("New Answer")
      expect(mail.to).to eq([question.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.body.encoded).to match(answer.body.truncate(10))
    end
  end

  describe "subscribed_question" do
    let(:user) { create :user }
    let(:new_user) { create :user }
    let!(:question) { create :question, user: user }
    let!(:answer) { create :answer, question: question, user: new_user }
    let!(:user_mail) { create :user_mail, question: question, user: user }
    let!(:mail) { QuestionsMailer.subscribed_question(question, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Subscribed Question")
      expect(mail.to).to eq([question.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.body.encoded).to match(question.title.truncate(10))
    end
  end
end
