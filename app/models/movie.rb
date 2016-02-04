class Movie < ActiveRecord::Base

  def flop?
    released? && total_gross < 20_000_000
  end

  def released?
    released_on <= Time.zone.now
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
