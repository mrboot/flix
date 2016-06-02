class Review < ActiveRecord::Base

  belongs_to :movie
  belongs_to :user

  validates :location, presence: true
  validates :comment, length: { minimum: 4 }

  STARS = [5,4,3,2,1]
  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }

  def star_values
    STARS
  end
end
