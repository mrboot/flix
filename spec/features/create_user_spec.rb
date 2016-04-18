describe "when creating a user" do

  it 'should render a blank form' do
    visit root_path

    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)
    expect(find_field('Name').value).to be_blank
    expect(find_field('Username').value).to be_blank
    expect(find_field('Email').value).to be_blank
    expect(find_field('Password').value).to be_blank
    expect(find_field('Confirm Password').value).to be_blank
  end

  it 'should save a valid user and show the detail page & flash message' do
    visit signup_path

    fill_in('Name', with: 'Foobar Kadigan')
    fill_in('Username', with: 'FKadigan')
    fill_in('Email', with: 'foobar@kadigan.com')
    fill_in('Password', with: 'FoobarKadigan')
    fill_in('Confirm Password', with: 'FoobarKadigan')

    click_button 'Create Account'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_text('Foobar Kadigan')
    expect(page).to have_text("Thanks for signing up!")
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it 'should not create a new record if the data is invalid' do
    visit signup_path

    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    # expect(current_path).to eq(users_path)
    expect(page).to have_text('error')
  end

end
