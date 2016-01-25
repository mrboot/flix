describe "A movie" do

  it 'should be a flop if total gross less than £20,000,000' do
    movie = Movie.new(total_gross: 18_000_000)

    expect(movie.flop?).to be_truthy
  end

  it 'should be a flop if total gross is blank' do
    movie = Movie.new(total_gross: nil)

    expect(movie.flop?).to be_truthy
  end

  it 'should be a flop if total gross less than £20,000,000' do
    movie = Movie.new(total_gross: 25_000_000)

    expect(movie.flop?).to be_falsey
  end

end
