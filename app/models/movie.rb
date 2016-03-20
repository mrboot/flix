class Movie < ActiveRecord::Base

  RATINGS = %w(U G PG 12 12A PG-13 15 R NC-17 18)

  # has_attached_file is a paperclip method.
  has_attached_file :image

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

  has_many :reviews, dependent: :destroy

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

  def self.released
    where("released_on <= ?", Time.zone.now).order(released_on: :desc)
  end

  def self.hits
    where('total_gross >= ?', 300_000_000).order(total_gross: :desc)
  end

  def self.flops
    where('total_gross <= ? and released_on <= ?', 50_000_000, Time.zone.now).order(total_gross: :asc)
  end

  def self.recently_added
    order(created_at: :desc).limit(3)
  end

  def average_stars
    reviews.average(:stars)
  end

  def recent_reviews
    reviews.order('created_at desc').limit(2)
  end

end
