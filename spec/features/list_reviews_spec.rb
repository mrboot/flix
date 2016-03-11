describe "when viewing the list of reviews" do

  it 'should list only the reviews for the current movie' do
    movie1 = Movie.create(movie_attributes(title: "The Great Escape"))
    review1 = movie1.reviews.create(review_attributes(name: "Barry Humphreys"))
    review2 = movie1.reviews.create(review_attributes(name: "Mark Kermode"))

    movie2 = Movie.create(movie_attributes(title: "Battleship Potempkin"))
    review3 = movie2.reviews.create(review_attributes(name: "Robbie Collins"))

    visit movie_reviews_path(movie1)
    expect(page).to have_text(review1.name)
    expect(page).to have_text(review2.name)
    expect(page).not_to have_text(review3.name)
  end

end
