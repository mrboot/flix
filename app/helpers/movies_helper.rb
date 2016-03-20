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

  # def image_for(movie)
  #   if movie.image_file_name.blank?
  #     image_tag 'placeholder.png'
  #   else
  #     image_tag movie.image_file_name
  #   end
  # end
  # replaced above helper which looked for image file names with the below
  # which checks if an image exists at the URL
  def image_for(movie)
    if movie.image.exists?
      image_tag(movie.image.url)
    else
      image_tag('placeholder.png')
    end
  end

  def format_average_stars(movie)
    if movie.average_stars.nil?
      content_tag(:strong, 'No Reviews Yet')
    elsif movie.average_stars % 1 == 0
      pluralize(number_with_precision(movie.average_stars, precision: 0), 'Star')
    else
      pluralize(number_with_precision(movie.average_stars, precision: 1), 'Star')
    end
  end

end
