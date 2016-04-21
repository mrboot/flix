RSpec.describe UsersController, type: :controller do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access index" do
      get :index

      expect(response).to redirect_to(signin_url)
    end

    it "cannot access show" do
      get :show, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it "cannot access edit" do
      get :edit, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it "cannot access update" do
      patch :update, id: @user

      expect(response).to redirect_to(signin_url)
    end

    it "cannot access destroy" do
      delete :destroy, id: @user

      expect(response).to redirect_to(signin_url)
    end

  end

  context "when signed in" do

    before do
      @user2 = User.create!(user_attributes(email: "billy@example.com", username: "billybob1"))
      session[:user_id] = @user.id
    end

    it 'cannot edit a different user' do
      get :edit, id: @user2

      expect(response).to redirect_to(root_path)
    end

    it 'cannot delete a different user' do
      delete :destroy, id: @user2

      expect(response).to redirect_to(root_path)
    end

    it 'cannot update a different user' do
      patch :update, id: @user2

      expect(response).to redirect_to(root_path)
    end

  end

end
