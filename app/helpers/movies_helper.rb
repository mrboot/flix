module MoviesHelper

  def format_total_gross(movie)
    # movie.flop? ? content_tag(:strong, "Flop!") : number_to_currency(movie.total_gross, unit:"£")
    if movie.flop?
      content_tag(:strong, "Flop!")
    elsif not movie.released?
      content_tag(:strong, "Data not available")
    else
      number_to_currency(movie.total_gross, unit:"£")
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag 'placeholder.png'
    else
      image_tag movie.image_file_name
    end
  end

end
