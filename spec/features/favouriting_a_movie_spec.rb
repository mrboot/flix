describe "favouriting & unfavouriting a movie" do

  before do
    @user = User.create!(user_attributes)
    sign_in(@user)

    @movie = Movie.create(movie_attributes(title: "The Great Escape"))
  end

  context 'when favouriting a movie' do

    it 'should create a fav entry for signed in user and show un-fav button' do

      vist movie_path @movie

      expect(page).to have_text('0 Fans')

      expect {
        click_button 'Fave'
      }.to change(@user.favorites, :count).by(1)

      expect(current_path).to eq(movie_path(@movie))

      expect(page).to have_text("Thanks for fav'ing!")
      expect(page).to have_text("1 fan")
      expect(page).to have_button("Unfave")

    end

  end

  context "when unfavouriting a movie" do

    it 'should delete the fav entry for signed in user and show fav button' do

      vist movie_path @movie

      expect(page).to have_text('1 Fan')

      expect {
        click_button 'Unfave'
      }.to change(@user.favorites, :count).by(-1)

      expect(current_path).to eq(movie_path(@movie))

      expect(page).to have_text("Sorry you unfaved it!")
      expect(page).to have_text("0 fans")
      expect(page).to have_button("Fave")

    end

  end

end
