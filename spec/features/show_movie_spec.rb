# require 'rails_helper'

describe "When showing an individual movie" do

  it 'should show the full details of that movie' do
    @movie = Movie.create(movie_attributes)

    visit movie_url(@movie)

    expect(page).to have_text(@movie.title)
    expect(page).to have_text(@movie.rating)
    expect(page).to have_text(@movie.description)
    expect(page).to have_text(@movie.released_on.to_s(:short_ordinal))
    # expect(page).to have_selector(("img[src^='/assets/#{@movie.image_file_name.split('.')[0]}']"))
    expect(page).to have_selector("img[src$='#{@movie.image.url(:small)}']")
    expect(page).to have_text(@movie.cast)
    expect(page).to have_text(@movie.director)
    expect(page).to have_text(@movie.duration)
  end

  it 'should display a placeholder image if no poster image specified' do
    # @movie = Movie.create(movie_attributes(image_file_name: ''))
    @movie = Movie.create(movie_no_image_attributes)

    visit movie_url(@movie)

    expect(page).to have_selector(("img[src^='/assets/placeholder']"))
  end

  it 'should display Flop! if total gross less than £20,000,000' do
    @movie = Movie.create(movie_attributes(total_gross: 18_000_000))

    visit movie_url(@movie)

    expect(page).to have_text('Flop!')
  end

  it 'should display the total gross if the total gross is over £20,000,000' do
    @movie = Movie.create(movie_attributes(total_gross: 25_000_000))

    visit movie_url(@movie)

    expect(page).to have_text('£25,000,000.00')
  end

end
