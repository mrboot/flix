class Movie < ActiveRecord::Base

  RATINGS = %w(U G PG 12 12A PG-13 15 R NC-17 18)

  # has_attached_file is a paperclip method.
  # The styles bit tells it to use Imagemagick to upload both a small and thumnail
  # size image.  Can then sepcify on display which size to use.
  has_attached_file :image, styles: {
    small: "90x133>",
    thumb: "50x50>"
  }

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0.00 }
  # validates :image_file_name, allow_blank: true, format: {
  #           with: /\w+\.(png|jpg|gif)\z/i,
  #           message: "Image must be one of PNG, JPG or GIF" }
  # change the above validation for 'static' images to the below for uploaded paperclip images
  validates_attachment :image,
                       :content_type => { :content_type => ['image/jpeg', 'image/png'] },
                       :size => { :less_than => 1.megabyte }
  validates :rating, inclusion: {
            in: RATINGS,
            mesage: "Must be a valid rating" }

  has_many :reviews -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations
  has_many :genres, through: :characterizations

  scope :released, -> { where("released_on <= ?", Time.zone.now).order(released_on: :desc) }
  scope :hits, -> { where('total_gross >= ?', 300_000_000).order(total_gross: :desc) }
  scope :flops, -> { where('total_gross <= ? and released_on <= ?', 50_000_000, Time.zone.now).order(total_gross: :asc) }
  scope :recently_added, ->(max=3) { order(created_at: :desc).limit(max) }
  scope :upcoming, -> { where("released_on > ?", Time.zone.now).order(released_on: :desc) }
  scope :rated, ->(rating) { released.where("rating = ?", rating) }
  scope :recent, ->(max=5) { released.limit(max) }

  def flop?
    # released? && total_gross.to_i < 20_000_000
    cult_film? ? false : released? && total_gross.to_i < 20_000_000
  end

  def cult_film?
    reviews.size >= 50 && average_stars >= 4
  end

  def released?
    released_on.blank? ? false : released_on <= Time.zone.now
  end

  def average_stars
    reviews.average(:stars)
  end

  def recent_reviews
    reviews.order('created_at desc').limit(2)
  end

  # def self.released
  #   where("released_on <= ?", Time.zone.now).order(released_on: :desc)
  # end

  # def self.hits
  #   where('total_gross >= ?', 300_000_000).order(total_gross: :desc)
  # end

  # def self.flops
  #   where('total_gross <= ? and released_on <= ?', 50_000_000, Time.zone.now).order(total_gross: :asc)
  # end

  # def self.recently_added
  #   order(created_at: :desc).limit(3)
  # end

end
