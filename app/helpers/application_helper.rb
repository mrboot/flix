module ApplicationHelper

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  def display_title
    if content_for?(:title)
      content_tag(:title, "flix - #{content_for :title}")
    else
      content_tag(:title, "flix")
    end
  end

  def title(title)
    content_for :title, title
  end

  def nav_link_to(text, url)
    classes = ['button']
    classes << 'active' if current_page?(url)
    link_to(text, url, class: classes.join(' '))
  end

end
