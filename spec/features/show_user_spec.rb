describe "when showing an individual user" do

  before(:each) do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it 'should display the user detail' do
    visit user_path(@user)

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.username)
    expect(page).to have_text(@user.email)
  end

  it 'should display favourite movies in the sidebar' do
    movie = Movie.create(movie_attributes)
    @user.favorite_movies << movie

    visit user_path @user

    within("aside#sidebar") do
      expect(page).to have_text(movie.title)
    end
  end

  it 'should have have the user name in the titlebar' do
    visit user_path @user

    expect(page).to have_title "flix - #{@user.name}"
  end

end
