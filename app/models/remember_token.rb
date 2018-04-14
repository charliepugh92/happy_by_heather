class RememberToken < ApplicationRecord
  belongs_to :user

  validates :user, :remember_digest, presence: true
end
