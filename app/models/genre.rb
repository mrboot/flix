class Genre < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :characterizations
  has_many :movies, through: :characterizations

end
