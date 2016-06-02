module UsersHelper

  def format_member_since(member)
    member.created_at.strftime("%B %Y")
  end

  # def profile_image_for(user)
  #   gravatr_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
  #   image_tag gravatr_url, alt: "Profile Picture"
  # end

  def profile_image_for(user, options={})
    size = options[:size] || 80
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name)
  end

end
