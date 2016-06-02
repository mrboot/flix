describe "when viewing the list of reviews" do

  it 'should list only the reviews for the current movie' do
    @user = User.create!(user_attributes)
    sign_in(@user)

    movie1 = Movie.create(movie_attributes(title: "The Great Escape"))
    review1 = movie1.reviews.create!(review_attributes(comment: "Loved", user: @user))
    review2 = movie1.reviews.create!(review_attributes(comment: "Liked", user: @user))

    movie2 = Movie.create(movie_attributes(title: "Battleship Potempkin"))
    review3 = movie2.reviews.create!(review_attributes(comment: "Boo!", user: @user))

    visit movie_reviews_path(movie1)
    expect(page).to have_text(review1.comment)
    expect(page).to have_text(review2.comment)
    expect(page).not_to have_text(review3.comment)
  end

end
