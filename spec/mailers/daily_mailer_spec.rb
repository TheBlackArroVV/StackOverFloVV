require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let(:user) { create :user }
    let!(:question) { create :question, user: user }
    let(:mail) { DailyMailer.digest(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Digest")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.body.encoded).to match(question.title.truncate(10))
    end
  end
end
