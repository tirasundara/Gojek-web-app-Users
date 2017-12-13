class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 51 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :phone, presence: true, uniqueness: true, numericality: true, length: { minimum: 11, maximum: 12 }
  validates :gopay_balance, presence: true, numericality: { greater_than_or_equal_to: 0.0 }, on: :update, if: :gopay_balance_changed?

  private

  def downcase_email
    self.email = email.downcase if !email.nil?
  end

  # def gopay_changed?
  #   self.gopay_balance_changed?
  # end
end
