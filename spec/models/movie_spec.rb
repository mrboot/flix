describe "A movie" do

  it 'should be a flop if released & total gross less than £20,000,000' do
    movie = Movie.new(total_gross: 18_000_000, released_on: 3.months.ago)

    expect(movie.flop?).to be_truthy
  end

  it 'should not be a flop if released & total gross more than £20,000,000' do
    movie = Movie.new(total_gross: 25_000_000, released_on: 3.months.ago)

    expect(movie.flop?).to be_falsey
  end

  it 'should be a flop if released & total gross is blank' do
    movie = Movie.new(total_gross: nil, released_on: 3.months.ago)

    expect(movie.flop?).to be_truthy
  end

  it 'should not be a flop if it is not released yet' do
    movie = Movie.new(total_gross: 25_000_000)

    expect(movie.flop?).to be_falsey
  end

  it "should not be a flop if average rating is more than 4 stars over 50+ reviews" do
    movie = Movie.create(movie_attributes(total_gross: 18_000_000, released_on: 3.months.ago))
    50.times do
      movie.reviews.create(review_attributes(stars:4))
    end

    expect(movie.flop?).to be_falsey
  end

  it "is released when the released on date is in the past" do
    movie = Movie.create(movie_attributes(released_on: 3.months.ago))

    expect(Movie.released).to include(movie)
  end

  it "is not released when the released on date is in the future" do
    movie = Movie.create(movie_attributes(released_on: 3.months.from_now))

    expect(Movie.released).not_to include(movie)
  end

  it "is not released if the released on date is blank or nil" do
    movie = Movie.create(movie_attributes(released_on: nil))

    expect(Movie.released).not_to include(movie)
  end

  it "returns released movies ordered with the most recently-released movie first" do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end

  it "requires a title" do
    movie = Movie.new(title: "")

    movie.valid?  # populates errors

    expect(movie.errors[:title].any?).to eq(true)
  end

  it "requires a description" do
    movie = Movie.new(description: "")

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "requires a released on date" do
    movie = Movie.new(released_on: "")

    movie.valid?

    expect(movie.errors[:released_on].any?).to eq(true)
  end

  it "requires a duration" do
    movie = Movie.new(duration: "")

    movie.valid?

    expect(movie.errors[:duration].any?).to eq(true)
  end

  it "requires a description over 24 characters" do
    movie = Movie.new(description: "X" * 24)

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "accepts a $0 total gross" do
    movie = Movie.new(total_gross: 0.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "accepts a positive total gross" do
    movie = Movie.new(total_gross: 10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "rejects a negative total gross" do
    movie = Movie.new(total_gross: -10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "accepts any rating that is in an approved list" do
    ratings = %w[U G PG 12 12A PG-13 15 R NC-17 18]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(false)
    end
  end

  it "rejects any rating that is not in the approved list" do
    ratings = %w[R-13 R-16 R-18 R-21]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(true)
    end
  end

  it "is valid with example attributes" do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to eq(true)
  end

  it "has many reviews" do
    movie = Movie.new(movie_attributes)

    review1 = movie.reviews.new(review_attributes)
    review2 = movie.reviews.new(review_attributes)

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes)

    expect {
      movie.destroy
    }.to change(Review, :count).by(-1)
  end

  it 'calculates the average number of stars' do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 3))
    movie.reviews.create(review_attributes(stars: 5))
    movie.reviews.create(review_attributes(stars: 1))

    expect(movie.average_stars).to eq(3)
  end

end
