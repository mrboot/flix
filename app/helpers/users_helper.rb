module UsersHelper

  def format_member_since(member)
    member.created_at.strftime("%B %Y")
  end

  def profile_image_for(user)
    gravatr_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag gravatr_url, alt: "Profile Picture"
  end

end
