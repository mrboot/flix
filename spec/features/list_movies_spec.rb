# require 'rails_helper'

describe "Viewing the list of movies" do

  before(:each) do
    @movie1 = Movie.create(movie_attributes)

    @movie2 = Movie.create(movie_attributes(title: "Superman",
                          rating: "PG",
                          total_gross: 134218018.00,
                          description: "Clark Kent grows up to be the greatest super-hero",
                          released_on: "1978-12-15",
                          image: open("#{Rails.root}/app/assets/images/superman.jpg")))

    @movie3 = Movie.create(movie_attributes(title: "Spider-Man",
                          rating: "PG-13",
                          total_gross: 403706375.00,
                          description: "Peter Parker gets bitten by a genetically modified spider",
                          released_on: "2010-05-03",
                          image: open("#{Rails.root}/app/assets/images/spiderman.jpg")))
  end

  it 'should list the movies & their details' do
    visit movies_url

    # expect(page).to have_text('3 Movies')
    expect(page).to have_text(@movie1.title)
    expect(page).to have_text(@movie2.title)
    expect(page).to have_text(@movie3.title)

    expect(page).to have_text(@movie1.rating)
    expect(page).to have_text('(2008)')
    expect(page).to have_text('£318,412,101.00')
    expect(page).to have_text(@movie1.description[1..10])
    expect(page).to have_selector("img[src$='#{@movie1.image.url(:small)}']")
  end

  it "does not show a movie that hasn't yet been released" do
    movie = Movie.create(movie_attributes(title: "Guardians of the Galaxy II",
                                          released_on: 1.month.from_now))

    visit movies_path

    expect(page).not_to have_text(movie.title)
  end

end
