class User < ApplicationRecord
  include Tokenable

  # Defaults to :user => 1 in db
  enum role: [:admin, :user, :member]

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # Omniauth will not validate as has_secure_password added in validations which you have to disable
  # password also need to allow for blank option to avoid errors when saving
  has_secure_password
  validates :password, length: { minimum: 6 }

end
