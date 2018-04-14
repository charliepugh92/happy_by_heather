class User < ApplicationRecord
  has_many :remember_tokens
  attr_accessor :remember_token
  has_secure_password

  def remember
    new_remember_token = SecureRandom.urlsafe_base64
    id = remember_tokens.create(remember_digest: BCrypt::Password.create(new_remember_token)).id

    {
      token_id: id,
      token: new_remember_token
    }
  end
end
