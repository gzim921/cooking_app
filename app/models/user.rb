class User < ApplicationRecord
  MIN_PASS_LENGTH = 6
  MAX_PASS_LENGTH = 20
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PASSWORD = /\A # Must contain 8 or more charachters
                   (?=.*\d) # Must contain a digit
                   (?=.*[a-z]) # Must contain a lower case character
                   (?=.*[A-Z]) # Must contain an upper case character
                   (?=.*[[:^alnum:]]) # Must contain a symbol
                   /x
  has_secure_password

  has_many :recipes

  before_save :downcase_email, :capitalize_full_name

  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { in: MIN_PASS_LENGTH..MAX_PASS_LENGTH, message: 'must contain at least 6 charachters' },
             format: { with: VALID_PASSWORD, message: 'must contain digit, lower - upper case and symbol' }
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    case_sensitive: false,
                    uniqueness: { message: 'already exists.' }

  private

  def downcase_email
    self.email = email.downcase
  end

  def capitalize_full_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end
