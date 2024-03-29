class User < ActiveRecord::Base

  # acts_as_followable
  # acts_as_follower

  has_secure_password validations: false

  has_many :cards, dependent: :destroy
  has_many :navigations, dependent: :destroy
  
  attr_accessor :remember_token, :external_service

  hstore_accessor :credentials, twitter_id:     :string,
                                twitter_login:  :string,
                                twitter_token:  :string,
                                twitter_secret: :string,
                                facebook_id:    :string,
                                facebook_token: :string

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }, confirmation: true, if: Proc.new{|u| u.external_service.blank? }, allow_blank: true
  
  before_save { self.email = email.downcase.strip }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def generate_password_reset_token!
    generate_token(:password_reset_token)
    save!
  end

  private

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while self.class.exists?(column => self[column])
    end

    

end