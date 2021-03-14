require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  
  let(:movie) { FactoryGirl.create(:movie, title:"Testmovie") }
  let!(:movie1) { FactoryGirl.create(:movie, title: 'Catch me if you can', director: 'Steven Spielberg') }
  let!(:movie2) { FactoryGirl.create(:movie, title: 'Seven', director: 'David Fincher') }
  let!(:movie3) { FactoryGirl.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') }
  let!(:movie4) { FactoryGirl.create(:movie, title: "Stop") }
  describe 'Search movies by the same director' do
    it 'should redirect to home page if no director exists' do
      get :similar, { id: movie1.id }
    end
    
    it 'should call Movie.with_directors model method' do
      Movie.should_receive(:with_director).with(movie.title)
      get :similar, { id: movie.id } #
    end
    
    it 'should assign similar movies if director exists' do
      #movies = [movie1, movie3]
      Movie.stub(:with_director).with(movie.title).and_return("Testmovie")
      get :similar, { id: movie.id }
      expect(assigns(:with_director)).to eql(movie1)
    end
  end
  

end
