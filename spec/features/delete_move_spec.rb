describe "when deleting a movie" do

  before :each do
    @movie = Movie.create(movie_attributes(title: 'Rotten Movie'))
    @admin = User.create!(admin_user_attributes)
    sign_in(@admin)
  end

  it 'should remove the movie from the database and redirect to the index page' do
    visit movie_path(@movie)

    click_link 'Delete'

    expect(current_path).to eq(root_path)
    # expect(page).not_to have_text(@movie.title)
    expect(page).to have_text("Movie '#{@movie.title}' deleted!")
  end

end
