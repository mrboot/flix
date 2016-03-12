describe "when creating a review" do

  before(:each) do
    @movie = Movie.create(movie_attributes)
  end

  it 'should render a blank form' do
    visit movie_reviews_path @movie
    click_link 'Add Review'

    expect(current_path).to eq(new_movie_review_path(@movie))
    expect(find_field('Name').value).to be_blank
    # expect(find_field('Stars').value).to be_blank
    expect(find_field('Comment').value).to be_blank
    expect(find_field('Location').value).to be_blank
  end

  it 'should create a new record in the database if the data is valid' do
    visit new_movie_review_path @movie

    fill_in('Name', :with => 'Tom Jones')
    fill_in "Comment", with: "I have never seen a film this good before!"
    fill_in "Location", with: "London"
    choose 'review_stars_3'

    click_button('Create Review')

    expect(current_path).to eq(movie_reviews_path @movie)
    expect(page).to have_text('Tom Jones')
  end

  it 'should not save the review if its invalid' do
    visit new_movie_review_path @movie

    expect {
      click_button 'Create Review'
    }.not_to change(Review, :count)

    expect(current_path).to eq(movie_reviews_path(@movie))
    expect(page).to have_text('error')
  end

  it 'should display a flash message on success' do
    visit new_movie_review_path @movie

    fill_in('Name', :with => 'Tom Jones')
    fill_in "Comment", with: "I have never seen a film this good before!"
    fill_in "Location", with: "London"
    choose 'review_stars_3'

    click_button('Create Review')

    expect(current_path).to eq(movie_reviews_path(@movie))
    expect(page).to have_text('Thanks for your review!')
  end

end
