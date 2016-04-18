describe "when viewing a list of users" do

  before(:each) do
    @user1 = User.create(user_attributes)
    @user2 = User.create( name: "Joe Temp",
                          username: "jtemp",
                          email: "jtemp@example.com",
                          password: "Password01",
                          password_confirmation: "Password01" )
    @user3 = User.create( name: "Jane Temp",
                          username: "jtemp2",
                          email: "jane.temp@example.com",
                          password: "Password01",
                          password_confirmation: "Password01" )

    sign_in(@user1)
  end

  it 'should list users and their details' do
    visit users_path

    expect(page).to have_text(@user1.name)
    expect(page).to have_text(@user2.name)
    expect(page).to have_text(@user3.name)
  end

end
