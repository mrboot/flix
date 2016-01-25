describe "when navigating movies" do

  before(:each) do
    @movie = Movie.create(movie_attributes)
  end

  it 'should allow navigation from the detail page to the listing (root) page' do
    visit movie_url(@movie)

    click_link "All Movies"

    expect(current_path).to eq(root_path)
  end

  it 'should allow navigation from the index page to a specific movie' do
    visit movies_url

    click_link @movie.title

    expect(current_path).to eq(movie_path(@movie))
  end

end
