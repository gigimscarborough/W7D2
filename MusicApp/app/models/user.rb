class User < ApplicationRecord
    validates :email, :password_digest, :session_token, presence: true
    validates :email, :session_token, uniqueness: true
    validates :password, length:{ minimum: 5}, allow_nil: true

    after_initialize :ensure_session_token


    attr_reader :password
    
    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return user if user && user.is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcrypt_password = BCrypt::Password.new(self.password_digest)
        bcrypt_password.is_password?(password)
    end

    def reset_session_token!
        self.update!(session_token: generate_session_token)
    end

    private

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end
end
