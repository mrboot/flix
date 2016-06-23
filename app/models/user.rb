class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                    format: {
                      with: /\S+@\S+\.\w+/i,
                      message: "Must be a valid email address"
                    },
                    uniqueness: { case_sensitive: false }
  # password is not required when updatong so allow_blank added to ensure this is
  # not enforced on those saves.
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, presence: true,
                      format: { with: /\A[A-Z0-9]+\z/i,
                        message: "only allows letters and numbers" },
                      uniqueness: { case_sensitive: false }

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  before_save :format_username, :format_email

  scope :by_name, -> { order(name: :asc) }
  scope :non_admin, -> { where(admin: false).by_name }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = User.find_by_email(email_or_username) || User.find_by_username(email_or_username)
    user && user.authenticate(password)
  end

  def format_username
    self.username = username.downcase
  end

  def format_email
    self.email = email.downcase
  end

  def to_param
    username
  end

end
