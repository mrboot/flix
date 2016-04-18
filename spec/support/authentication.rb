def sign_in(user)
  visit signin_path
  fill_in "email_or_username", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
