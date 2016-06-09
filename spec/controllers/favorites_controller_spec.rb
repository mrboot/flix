require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  context 'when not signed in' do

    before do
      session[:user_id] = nil
    end

    it "cannot access create" do
      get :create, movie_id: @movie

      expect(response).to redirect_to(signin_url)
    end

    it "cannot access delete" do
      delete :destroy, id: 1, movie_id: @movie

      expect(response).to redirect_to(signin_url)
    end

  end

end
