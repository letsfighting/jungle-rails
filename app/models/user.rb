class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  validates :fname, presence: true
  validates :lname, presence: true

  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credientials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
