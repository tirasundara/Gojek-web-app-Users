class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 51 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  private

  def downcase_email
    self.email = email.downcase if !email.nil?
  end

end
