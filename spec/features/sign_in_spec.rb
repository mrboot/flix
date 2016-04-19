describe "Signing in" do

  before(:each) do
    @user = User.create!(user_attributes)
  end

  context 'when not signed in' do

    it 'header should display sign up and sign in links' do
      visit root_path

      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Sign In")
    end

    it 'sign-in link should display a sign-in form' do
      visit root_path

      click_link('Sign In')

      expect(current_path).to eq(signin_path)
      expect(page).to have_field('email_or_username')
      expect(page).to have_field('Password')
    end

    it 'should sign in a valid user' do
      # sign_in is a spec helper method in spec/support/authentication.rb
      sign_in(@user)

      expect(current_path).to eq(user_path(@user))
      expect(page).to have_text("Welcome back #{@user.name}!")
    end

    it 'should not sign in an invalid user' do
      visit signin_path

      fill_in('email_or_username', with: @user.email)
      fill_in('Password', with: 'hello')

      click_button('Sign In')

      expect(current_path).to eq(session_path)
      expect(page).to have_text('invalid username or password')
    end

    it 'should redirect to the intended page' do
      visit users_path

      expect(current_path).to eq(signin_path)

      sign_in(@user)

      expect(current_path).to eq(users_path)
    end

  end

  context "when signed in" do

    it 'header should display the usernme and sign out links' do
      sign_in(@user)

      expect(page).to have_link(@user.name)
      expect(page).to have_link("Sign Out")
      expect(page).not_to have_link("Sign Up")
    end

    it 'sign out link should sign out user ' do
      sign_in(@user)
      click_link('Sign Out')

      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Sign In")
      expect(page).to have_text("Logged out!")
    end

  end

end
