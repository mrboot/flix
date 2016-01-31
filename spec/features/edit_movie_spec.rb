describe "when editing a movie" do

  before :each do
    @movie = Movie.create(movie_attributes)
  end

  it 'should display all the fields' do
    visit movie_url(@movie)

    click_link('Edit')

    expect(current_path).to eq(edit_movie_path(@movie))

    expect(find_field('Title').value).to eq(@movie.title)
  end

  xit 'should update the database with the edited value' do
    visit edit_movie_url(@movie)

    fill_in('Description', :with => 'Really Long Text...')

    click_button('Update Movie')

    expect(@movie.description).to eq('Really Long Text...')
  end

end