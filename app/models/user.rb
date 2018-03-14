class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password

  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    update(remember_digest: BCrypt::Password.create(remember_token))
  end
end
