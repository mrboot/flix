class Movie < ActiveRecord::Base

  RATINGS = %w(U G PG 12 12A PG-13 15 R NC-17 18)

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0.00 }
  validates :image_file_name, allow_blank: true, format: {
            with: /\w+\.(png|jpg|gif)\z/i,
            message: "Image must be one of PNG, JPG or GIF" }
  validates :rating, inclusion: {
            in: RATINGS,
            mesage: "Must be a valid rating" }

  has_many :reviews, dependent: :destroy

  def flop?
    released? && total_gross.to_i < 20_000_000
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

end
