describe "Deleting a user" do

  before do
    @user = User.create!(user_attributes)
  end

  context "when signed in as a standard user" do

    it 'should not have the delete link present' do
      sign_in(@user)

      visit user_path(@user)

      expect(page).not_to have_link('Delete Account')
    end

  end

  context 'when signed in as an admin user' do

    before do
      @admin = User.create!(admin_user_attributes)
      sign_in(@admin)
    end

    it 'should remove the account from the system & redirect to the user listing' do
      visit user_path(@user)

      click_link('Delete Account')

      expect(current_path).to eq(root_path)
      expect(page).not_to have_text(@user.name)
      expect(page).to have_text('Account deleted')
    end

  end

end
