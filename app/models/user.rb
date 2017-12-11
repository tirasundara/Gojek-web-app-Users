class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 51 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true, length: { minimum: 8 }

  has_secure_password

  private

  def downcase_email
    self.email = email.downcase if !email.nil?
  end

end
