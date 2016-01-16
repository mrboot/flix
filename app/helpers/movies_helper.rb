module MoviesHelper

  def format_total_gross(movie)
    movie.flop? ? content_tag(:strong, "Flop!") : number_to_currency(movie.total_gross, unit:"£")
  end

end
