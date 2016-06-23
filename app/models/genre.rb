class Genre < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: true

  has_many :characterizations
  has_many :movies, through: :characterizations

  before_validation :generate_slug

  def to_param
    name.parameterize
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize if name
  end

end
