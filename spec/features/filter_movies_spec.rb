describe "when filtering movies" do

  it 'should display hit movies when clicking the hits link' do
    movie = Movie.create!(movie_attributes(released_on: 5.days.ago, total_gross: 500_000_000))
    visit movies_path

    click_link 'Hits'

    expect(current_path).to eq('/movies/filter/hits')
    expect(page).to have_text(movie.title)
  end

  it 'should display flop movies when clicking the flops link' do
    movie = Movie.create!(movie_attributes(released_on: 5.days.ago, total_gross: 5_000_000))
    visit movies_path

    click_link 'Flops'

    expect(current_path).to eq('/movies/filter/flops')
    expect(page).to have_text(movie.title)
  end

  it 'should display upcoming movies when clicking the Upcoming link' do
    movie = Movie.create!(movie_attributes(released_on: 5.days.from_now))
    visit movies_path

    click_link 'Upcoming'

    expect(current_path).to eq('/movies/filter/upcoming')
    expect(page).to have_text(movie.title)
  end

  it 'should display recent movies when clicking the recent link' do
    movie = Movie.create!(movie_attributes(released_on: 5.days.ago))
    visit movies_path

    click_link 'Recent'

    expect(current_path).to eq('/movies/filter/recent')
    expect(page).to have_text(movie.title)
  end

end
