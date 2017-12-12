require 'rails_helper'

RSpec.describe User, type: :model do

  # valid factory
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:name).is_at_most(51) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(8) }

  # validation of email format
  describe "Email format Validation" do
    it "is valid email format" do
      user = build(:user, email: "sundaralinus@gmail.com")
      expect(user).to be_valid
    end
    it "is invalid email format" do
      user = build(:user, email: "sundaralinus@gmail,com")
      expect(user).not_to be_valid
    end
    it "downcases an email before saving" do
      user = create(:user, email: "sunDaRaLinuS@gMail.CoM")
      expect(user.email).to match(/sundaralinus@gmail.com/)
    end
  end

  # it { should validate_presence_of(:gopay_balance) }
  # it { should validate_numericality_of(:gopay_balance).is_greater_than_or_equal_to(0.0) }
end
