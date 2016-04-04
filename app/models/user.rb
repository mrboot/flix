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
end
