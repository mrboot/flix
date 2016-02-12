describe "when creating a movie" do

  it 'should render a blank form' do
    visit root_path

    click_link 'Add Movie'

    expect(current_path).to eq(new_movie_path)

    expect(find_field('Title').value).to be_blank
    expect(find_field('Description').value).to be_blank
    expect(find_field('Rating').value).to be_blank
    expect(find_field('Total gross').value).to be_blank
    expect(find_field('Image file name').value).to be_blank
    expect(find_field('Director').value).to be_blank
    expect(find_field('Cast').value).to be_blank
    expect(find_field('Duration').value).to be_blank
  end

  it 'should create a new record in the database' do
    visit new_movie_path

    fill_in('Title', :with => 'Star Wars: The Force Awakens')
    fill_in "Description", with: "Star Wars lives again with the next installment in the franchise"
    fill_in "Rating", with: "12a"
    fill_in "Total gross", with: "75000000"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"

    click_button('Create Movie')

    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text('Star Wars: The Force Awakens')
  end

end
