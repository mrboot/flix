describe MoviesController do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  context "when logged in as a normal user" do

    before do
      @user = User.create!(user_attributes)
      session[:user_id] = @user.id
    end

    it "cannot access new" do
      get :new

      expect(response).to redirect_to(root_url)
    end

    it "cannot access create" do
      post :create

      expect(response).to redirect_to(root_url)
    end

    it "cannot access edit" do
      get :edit, id: @movie

      expect(response).to redirect_to(root_path)
    end

    it "cannot access update" do
      patch :update, id: @movie

      expect(response).to redirect_to(root_path)
    end

    it "cannot access destroy" do
      delete :destroy, id: @movie

      expect(response).to redirect_to(root_path)
    end

  end

  context 'when logged in as an admin' do

    before do
      @admin = User.create!(admin_user_attributes)
      session[:user_id] = @admin.id
    end

    it 'can access create' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'can access edit' do
      get :edit, id: @movie

      expect(response).to render_template(:edit)
    end

    it 'can delete a movie' do
      expect { delete :destroy, id: @movie
        }.to change(Movie,:count).by(-1)
    end

  end

end
