class User < ApplicationRecord
  include Tokenable

  has_many :weights

  # Defaults to :user => 1 in db
  enum role: [:admin, :user, :member]

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, length: { minimum: 6 }

end
