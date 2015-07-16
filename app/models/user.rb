class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :session_token, uniqueness: true

  after_initialize :ensure_session_token

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = find_by(email: email)

    return nil if user.nil?

    user.is_password(password) ? user : nil
  end

  def self.generate_session_token
    # TODO ensure it is not in the database
    SecureRandom::urlsafe_base64
  end
end
