describe "when deleting a user" do

  before(:each) do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it 'should remove the account from the system & redirect to the user listing' do
    visit user_path(@user)

    click_link('Delete Account')

    expect(current_path).to eq(root_path)
    expect(page).not_to have_text(@user.name)
    expect(page).to have_text('Account deleted')
  end

end
