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

end
