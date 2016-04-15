describe "when editing a user" do

  before(:each) do
    @user = User.create!(user_attributes)
  end

  it 'should display the fields to edit populated with data' do
    visit user_path(@user)

    click_link('Edit Account')

    expect(current_path).to eq(edit_user_path(@user))

    expect(find_field('Name').value).to eq(@user.name)
    expect(find_field('Username').value).to eq(@user.username)
  end

  it 'should update the database with the new values & display a flash message' do
    visit edit_user_path(@user)

    fill_in('Name', :with => 'Mark Booth')

    click_button('Update Account')

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text('Mark Booth')
    expect(page).to have_text('Account details updated')
  end

  it 'should not update the database if data is invalid' do
    visit edit_user_path(@user)

    fill_in('Name', :with => '')

    click_button('Update Account')

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text('error')
  end

end
