require "rails_helper"

RSpec.describe SafetyMailer, type: :mailer do
  describe "inebriation warning" do
    let(:user) { create(:user, email: 'smculliton@gmail.com') }
    let(:mail) { SafetyMailer.with(user: user).safety_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Our records indicate you might be inebriated")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["brucycle.cares@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.include?('Are you drunk?')).to eq(true)
    end
  end
end
