describe "when showing an individual user" do

  before(:each) do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it 'should display the user detail' do
    visit user_path(@user)

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.username)
    expect(page).to have_text(@user.email)
  end

end
