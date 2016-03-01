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

  it 'should update the database with the edited value' do
    visit edit_movie_url(@movie)

    fill_in('Description', :with => 'Movie description that has Really Long Text...')

    click_button('Update Movie')

    expect(current_path).to eq(movie_path(@movie))
    expect(page).to have_text('Movie description that has Really Long Text...')
  end

  it "should not update the movie if it's invalid" do
    movie = Movie.create(movie_attributes)

    visit edit_movie_url(movie)

    fill_in 'Title', with: " "

    click_button 'Update Movie'

    expect(page).to have_text('error')
  end

  it 'should diaplay a flash message on success' do
    visit edit_movie_url(@movie)

    fill_in 'Title', with: "Back to the future"

    click_button 'Update Movie'

    expect(current_path).to eq(movie_path(@movie))
    expect(page).to have_text('Movie successfully updated!')
  end

end
